Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2F3C9426
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991332; cv=none; b=btw0xfwyXKqA5b7c4mYej2yO9kgcg9B7tYF88QU1kzOs9agR66XCfkAWGTpBlQuI/WFaIQx/TfmXAw0KfSSkQ+fssrHHejzdLe2DDT2niFZkk9Gx3/kTGD3G4QebVYtcNqYIhjHSSwZRT1uwgoJJsnCZGmhQJjng730o8rHKBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991332; c=relaxed/simple;
	bh=qfLSwLN6Ol+jXm3x5LONEa89ry6IeI3Z+Thv5Do35kg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GHqfAIpCjg3fADPixAtqSAz1tTHXr8Uw7b1YNERTmWn22PkC1waXWgxmGs+QSCVgt774K1pOc1zcnHCBx5X2WJZqTbCFhmMA3yKGKDMG1a7sbR9ppvgIpuFby83qSovuJ53P2W7zXeWlMQATt5rpvcLcQldDUgggqce560ppNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNDoyhgP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNDoyhgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789991320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDDstnukHO3fXB3QQzZGwwQPB6jN0uwfpA+IQdz63lI=;
	b=RNDoyhgPOHBf0KokAawZQFt+HNiZvs3DY/S5v9ho7+ZsVqjvPJAX5MvSzlNlS1gBoC8HbD
	DP+Qp1hz/m6TC8rW1Ibvnp3+qbb5nGg6uq3PCVy/d7Kau0kwgd6GN4WLfcf5z0Q3WVgfYg
	H9H2lNiZfX0XPONq/cA7NIXrIS7hmUY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-xbZwO6_MPkmQltWAbZRu5A-1; Mon,
 21 Sep 2026 07:48:39 -0400
X-MC-Unique: xbZwO6_MPkmQltWAbZRu5A-1
X-Mimecast-MFC-AGG-ID: xbZwO6_MPkmQltWAbZRu5A_1789991318
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 350711843AD4;
	Mon, 21 Sep 2026 11:48:38 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C51A41B;
	Mon, 21 Sep 2026 11:48:35 +0000 (UTC)
Date: Mon, 21 Sep 2026 13:48:33 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ben Cressey <ben@cressey.dev>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dm-integrity: fix buffer overflow in inline mode with
 large tag size
In-Reply-To: <20260915-dm-integrity-inline-tag-v1-1-3076b1b27454@cressey.dev>
Message-ID: <5e7d601a-4119-e798-2a3d-cbfe80da1a0c@redhat.com>
References: <20260915-dm-integrity-inline-tag-v1-1-3076b1b27454@cressey.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hi

Accepted into the dm-7.3 branch.

Mikulas


On Tue, 15 Sep 2026, Ben Cressey wrote:

> In inline mode, dm_integrity_check and dm_integrity_inline_recheck
> compute the checksum of each block into an on-stack buffer of
> HASH_MAX_DIGESTSIZE bytes. integrity_sector_checksum pads its result
> with zeroes up to the tag size, so if the tag size is larger than
> HASH_MAX_DIGESTSIZE, the padding runs past the end of the buffer. With
> CONFIG_STACKPROTECTOR the kernel panics in dm_integrity_check on the
> first read.
> 
> Enlarge both buffers to hold MAX_TAG_SIZE bytes, as commit b93b6643e9b5
> ("dm integrity: fix a crash with unusually large tag size") did for
> integrity_metadata.
> 
> Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Cressey <ben@cressey.dev>
> Assisted-by: LLM
> ---
> To reproduce: QEMU nvme-ns with ms=128 and 4096-byte blocks, table
> "0 8192 integrity /dev/nvme0n1 0 100 I 3
> internal_hash:hmac(sha256):<key> fix_hmac block_size:4096", then read
> the device.
> 
> For stable: before commit 5076d4599ce1 ("dm-integrity: enable
> asynchronous hash interface") in 6.18, the dm_integrity_check buffer
> was in dm_integrity_end_io.
> ---
>  drivers/md/dm-integrity.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 92970e12267ab..0862f31b8498d 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -2721,7 +2721,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
>  	outgoing_data = dio->integrity_payload + PAGE_SIZE;
>  
>  	while (dio->bio_details.bi_iter.bi_size) {
> -		char digest[HASH_MAX_DIGESTSIZE];
> +		char digest[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
>  		int r;
>  		struct bio_integrity_payload *bip;
>  		struct bio_vec bv;
> @@ -2788,7 +2788,7 @@ static inline bool dm_integrity_check(struct dm_integrity_c *ic, struct dm_integ
>  	unsigned pos = 0;
>  
>  	while (dio->bio_details.bi_iter.bi_size) {
> -		char digest[HASH_MAX_DIGESTSIZE];
> +		char digest[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
>  		struct bio_vec bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
>  		char *mem = integrity_kmap(ic, bv.bv_page);
>  		integrity_sector_checksum(ic, &dio->ahash_req, dio->bio_details.bi_iter.bi_sector, mem, bv.bv_offset, digest);
> 
> ---
> base-commit: df2908090cda368b01ff43709f51890076c56157
> change-id: 20260915-dm-integrity-inline-tag-645e17849955
> 

