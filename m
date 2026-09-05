Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A123D28C;
	Sat,  5 Sep 2026 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568379; cv=none; b=W3D1fy9ovPlS0o3ny22zP94GnnqWLOyA63OMMaUuNF3WpIpLj/Hm9e94xf47LnfQFS1zmy8MD9tSsSEtvVRxC23R7PuFVxAn5w585g6cEtUcqUaCZWLN4Bns8kBKFi1vG5B9jU+EfguJDlk2bUaVYOsjVBQOqpnH2nKnEDtXafc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568379; c=relaxed/simple;
	bh=O7na85LJzeeW9urrmTT+ZcC5YkqIgHTZo4aYjjs6JNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMd6ka1tzbNMHwd6nx1VB/JbZ3e+groMBbJu6Kc+iy+thTZl3h7pv6PQrSethsPOQJJ+Y7pQG0bFnC2Vi467FuJApfdTilSjrw5ha2AkS94DILPCQgipAbUnH+fY7Bi0HzOjVf9v8KQ5ucah1ZMZxTAPMnspnamv/ZFgtJrygAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LviXth5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LviXth5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB001F00A3D;
	Sat,  5 Sep 2026 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788568377;
	bh=Q5oBfAwVgZGXYsPQcMyKaSyqzRQDV+E4ggbXvLfpz8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LviXth5l1ro8TYsEj8bIErmuV36c+DsXqxY3I/u5WRXhbGGnIGpzjTFos9yRKs33H
	 yZb/FfWlW+nLzEx9F7VpBYohgc2xwGuvok+JgAMWjmx1tF/y86IW9CO6l5GV5Ec65s
	 9cvegQqK+dZ0OZpD0Ql8mGg/0D092dfkWREg+XAIw77yi7InzQRjceCvJYOhL97iPI
	 KvP3UK5WN655fClRGCJCA6uK9OLWMMQfV7TBEp4k1682dLTnyD5kpVX5D6TtV/p9dr
	 M6irV93RRdOWaBJajQ13S+1XVc5pQwLteoIsgvrVDny7/HOXoqFjjypwyBC5ezpJzh
	 ukgNhUKn9g0Lw==
Date: Fri, 4 Sep 2026 21:32:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: markdamirkan@gmail.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf evsel: Validate cross-endian samples before
 byte swapping
Message-ID: <aptjNjaz3RYTW-TF@x2>
References: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
 <CAP-5=fW5uHsW0wgffWgc8f5ibDf8ArF8qJW6sWzrorL44CqnNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW5uHsW0wgffWgc8f5ibDf8ArF8qJW6sWzrorL44CqnNw@mail.gmail.com>

On Thu, Sep 03, 2026 at 01:19:07PM -0700, Ian Rogers wrote:
> On Thu, Sep 3, 2026 at 4:05 AM Mark Amirkan via B4 Relay
> <devnull+markdamirkan.gmail.com@kernel.org> wrote:
> >
> > Two paths in __evsel__parse_sample() use values from an
> > opposite-endian perf.data record to modify the record before checking that
> > the data fits within event->header.size.
> >
> > Patch 1 checks the complete branch stack before swapping entry flags.
> > Patch 2 checks the RAW payload and the complete 64-bit words touched by
> > mem_bswap_64() before swapping the data.
> >
> > The malformed branch-stack and RAW records reproduce as out-of-bounds
> > reads and writes. Each patch adds a Sample parsing regression test that
> > checks rejected records do not modify data past the declared event.
> >
> > Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
