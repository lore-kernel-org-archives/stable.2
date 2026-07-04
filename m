Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96A1E9919;
	Sat,  4 Jul 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783184887; cv=none; b=sidkkXSaCHhdSYBsN9nFJl1rx/PBO2jPRv55PAbnOXJrLfUakNvoZusKKoz8ZllAzDyN8BTqUatckhk+xDlN7UM29Wo6Fj5Sy81Z56K0cvme2YkHiX6g514qbvLnO6BjEEdc0jp4pwWiQIOV9Yoe27hFwH/yT4aNFVBiJ107UzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783184887; c=relaxed/simple;
	bh=EWBT4hU7//0X1hV9mMHMOqeX+4OOwYshnIb4gV6S+nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPE6S/pO0U1ScBU8nV9ocorhIJtzddKl33tFep8lLqF3OooLRLKw7rHAwMSer0kgGruVIRiVBJnFl01ww6M+yuzZ2ZtreKmAsMPE87QU0uw1H2w0qNsJx6LEusxBWOzPWc/Q3OXm/GFsQI6bFtBQKi+nauysjYHQnWn3MTYlQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQGfGMqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQGfGMqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0081D1F000E9;
	Sat,  4 Jul 2026 17:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783184885;
	bh=qLWiwUkt1+vBYTVchITj+exqqY8WMBRAS+J1Qrcsag4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TQGfGMqavgUFnz58dPUoOKtbcVr3nolQXn8xl5cLR3DfRXVGHGgejYDl+vCdSXVGj
	 b5/AL3p5ALf0tKevcukQcrE2Zf660/P488mpT9d52je/jYchmlScptcDmULnYt3UH4
	 9C4YrbT1GAmZxqtklNJ/2D9U3tJZlpHA2hq6jRBhFa+ZLLKqDIw+E87Zr3MIG7mtVZ
	 Bf3U44bEINKmPKGV4ctM6Z/lzYjb55nnrDzYSdjIjlXYLKmirS0ReKvaMrcAQXEylb
	 VObD6nDGR5r3+xpDiLeRGGUaYEmBtiYHROQtjIEw4XzwK8zs1xj+zdf6464a0JZuQK
	 PrYseeXTFYwwg==
Date: Sat, 4 Jul 2026 10:08:03 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	kernel-team@meta.com, Farid Zakaria <fmzakari@meta.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf record: Fix multiple PERF_RECORD_COMPRESSED2
 records per push
Message-ID: <akk98zIfF08BoADo@google.com>
References: <cover.1782743187.git.d@ilvokhin.com>
 <079503c01a3e28d3775947f3449cadacfa1f4117.1782743187.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <079503c01a3e28d3775947f3449cadacfa1f4117.1782743187.git.d@ilvokhin.com>

Hello,

On Tue, Jun 30, 2026 at 07:17:00AM +0000, Dmitry Ilvokhin wrote:
> With Zstd compression enabled ('perf record -z'), a single mmap push
> whose compressed output exceeds the maximum record size makes
> zstd_compress_stream_to_records() emit several PERF_RECORD_COMPRESSED2
> records back to back. record__pushfn() however rewrote only the first
> record's header to describe the whole blob as one record:
> 
>   event->data_size   = compressed - sizeof(struct perf_record_compressed2);
>   event->header.size = PERF_ALIGN(compressed, sizeof(u64));
>   padding            = event->header.size - compressed;
>   ...
>   record__write(rec, map, &pad, padding);
> 
> perf_event_header::size is a __u16, so once the compressed blob no
> longer fits in it the header.size assignment truncates and 'padding'
> (size_t) underflows. write() is then handed that bogus length and fails
> with EFAULT, aborting the recording:
> 
>   failed to write perf data, error: Bad address
> 
> The bytes that did reach the file are mis-framed, so reading it back
> cannot be decompressed.
> 
> This is easy to hit with a high event rate and a large buffer, e.g.:
> 
>   perf record -z -F max -m 32M --per-thread -- perf test -w thloop 5 1
> 
> The single-record fixup is wrong by construction: because header.size is
> 16 bits a compressed record cannot exceed 64KB, so the compressor must
> split a push into a chain of records, and the session reader already
> consumes them as such.
> 
> Frame each record where it is produced instead: make
> process_comp_header() set the per-record data_size, 8-byte-align
> header.size and zero the trailing padding, and let record__pushfn()
> write the resulting blob, as the AIO path already does. Reduce
> max_record_size by sizeof(u64) so the per-record alignment padding
> cannot push header.size past its u16 field.
> 
> There is no on-disk format change; a perf.data written by the fixed tool
> is still read by existing perf.

Thanks for working on this!

> 
> Fixes: 208c0e168344 ("perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2")
> Reported-by: Farid Zakaria <fmzakari@meta.com>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Cc: stable@vger.kernel.org
> ---
>  tools/perf/builtin-record.c                   | 41 ++++++------
>  .../record+zstd_comp_decomp_multi_record.sh   | 64 +++++++++++++++++++
>  tools/perf/util/zstd.c                        |  2 +-
>  3 files changed, 87 insertions(+), 20 deletions(-)
>  create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4a5eba498c02..2562c3177eae 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -652,27 +652,14 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  	struct record *rec = to;
>  
>  	if (record__comp_enabled(rec)) {
> -		struct perf_record_compressed2 *event = map->data;
> -		size_t padding = 0;
> -		u8 pad[8] = {0};
>  		ssize_t compressed = zstd_compress(rec->session, map, map->data,
>  						   mmap__mmap_len(map), bf, size);
>  
>  		if (compressed < 0)
>  			return (int)compressed;
>  
> -		bf = event;
>  		thread->samples++;
> -
> -		/*
> -		 * The record from `zstd_compress` is not 8 bytes aligned, which would cause asan
> -		 * error. We make it aligned here.
> -		 */
> -		event->data_size = compressed - sizeof(struct perf_record_compressed2);
> -		event->header.size = PERF_ALIGN(compressed, sizeof(u64));
> -		padding = event->header.size - compressed;
> -		return record__write(rec, map, bf, compressed) ||
> -		       record__write(rec, map, &pad, padding);
> +		return record__write(rec, map, map->data, compressed);
>  	}
>  
>  	thread->samples++;
> @@ -1590,18 +1577,29 @@ static void record__adjust_affinity(struct record *rec, struct mmap *map)
>  	}
>  }
>  
> -static size_t process_comp_header(void *record, size_t increment)
> +/*
> + * Called once with data_size == 0 to start a record, then once with
> + * data_size == compressed payload size to finalize and 8-byte-pad it
> + * (unaligned records trip ASan in the reader).
> + */
> +static size_t process_comp_header(void *record, size_t data_size)
>  {
>  	struct perf_record_compressed2 *event = record;
>  	size_t size = sizeof(*event);
>  
> -	if (increment) {
> -		event->header.size += increment;
> -		return increment;
> +	if (data_size) {
> +		size_t padding;
> +
> +		event->data_size = data_size;
> +		event->header.size = PERF_ALIGN(size + data_size, sizeof(u64));
> +		padding = event->header.size - size - data_size;
> +		memset(record + size + data_size, 0, padding);
> +		return data_size + padding;
>  	}
>  
>  	event->header.type = PERF_RECORD_COMPRESSED2;
>  	event->header.size = size;
> +	event->data_size = 0;
>  
>  	return size;
>  }
> @@ -1610,7 +1608,12 @@ static ssize_t zstd_compress(struct perf_session *session, struct mmap *map,
>  			    void *dst, size_t dst_size, void *src, size_t src_size)
>  {
>  	ssize_t compressed;
> -	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed2) - 1;
> +	/*
> +	 * Reserve space so per-record PERF_ALIGN() padding keeps header.size
> +	 * within u16.
> +	 */
> +	size_t max_record_size = PERF_SAMPLE_MAX_SIZE
> +		- sizeof(struct perf_record_compressed2) - sizeof(u64);
>  	struct zstd_data *zstd_data = &session->zstd_data;
>  
>  	if (map && map->file)
> diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh b/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh
> new file mode 100755
> index 000000000000..42efe7260def
> --- /dev/null
> +++ b/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh
> @@ -0,0 +1,64 @@
> +#!/bin/bash
> +# Zstd perf.data compression/decompression of multi-record data
> +
> +# SPDX-License-Identifier: GPL-2.0

Can you please remove the blank line here?

Also, this series cannot apply anymore.  Please rebase onto the latest
perf-tools-next.

Thanks,
Namhyung

> +
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +recout=$(mktemp /tmp/__perf_test.zstd.rec.XXXXX)
> +injout=$(mktemp /tmp/__perf_test.zstd.inj.XXXXX)
> +perf_tool=perf
> +
> +cleanup() {
> +	rm -f "${perfdata}" "${perfdata}".old "${perfdata}".decomp "${recout}" "${injout}"
> +}
> +trap cleanup EXIT TERM INT
> +
> +skip_if_no_z_record() {
> +	$perf_tool record -h 2>&1 | grep -q -- '-z, --compression-level'
> +}
> +
> +collect_z_record() {
> +	echo "Collecting compressed record file:"
> +	[ "$(uname -m)" != s390x ] && gflag='-g'
> +	$perf_tool record -o "${perfdata}" $gflag -z -F max -m 32M --per-thread -- \
> +		$perf_tool test -w thloop 5 1 \
> +		>/dev/null 2>"${recout}"
> +}
> +
> +check_record() {
> +	echo "Checking record did not fail to write data:"
> +	if grep -q "failed to write perf data" "${recout}"; then
> +		cat "${recout}"
> +		return 1
> +	fi
> +}
> +
> +check_decompress() {
> +	echo "Checking compressed file decompresses cleanly:"
> +	if ! $perf_tool inject -i "${perfdata}" -o "${perfdata}".decomp 2>"${injout}"; then
> +		cat "${injout}"
> +		return 1
> +	fi
> +	if grep -Eqi "decompress|corrupt|failed to process type" "${injout}"; then
> +		cat "${injout}"
> +		return 1
> +	fi
> +}
> +
> +skip_if_no_z_record || exit 2
> +collect_z_record
> +check_record || exit 1
> +
> +# Need >1 record, else the multi-record path wasn't exercised.
> +# Skip rather than pass/fail spuriously.
> +nr=$($perf_tool report -i "${perfdata}" --stats 2>/dev/null |
> +	awk '/COMPRESSED2 events:/ { print $3 }')
> +if [ -z "${nr}" ] || [ "${nr}" -lt 2 ]; then
> +	echo "less than two compressed records (${nr:-0}), skipping"
> +	exit 2
> +fi
> +echo "Produced ${nr} compressed records"
> +
> +check_decompress
> +err=$?
> +exit $err
> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index 57027e0ac7b6..1955fa2431d1 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -30,7 +30,7 @@ int zstd_fini(struct zstd_data *data)
>  
>  ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>  				       void *src, size_t src_size, size_t max_record_size,
> -				       size_t process_header(void *record, size_t increment))
> +				       size_t process_header(void *record, size_t data_size))
>  {
>  	size_t ret, size, compressed = 0;
>  	ZSTD_inBuffer input = { src, src_size, 0 };
> -- 
> 2.53.0-Meta
> 
