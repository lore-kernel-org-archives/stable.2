Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992045;
	b=1gMDd8VQ0bx+Yf5AIHe1jo/iKBDgLuvmgdmS4ts25923k33twUc4oQQ+IuBP5oo/HY/7
	 uFd4A20zUhvIQMJrPGPAuHUVAi+LJHB+AObhIcZ6DUzM56eWa02wKgDM+APmkRJ9JwgLg
	 Lb7CAeo7QaHJ9oVnJi949/qYOCAlsBS2DgmjH+dnFfD7ZlguPbSIWjW89Se1BZ5kTjG9J
	 aeos3EmiuuCwuYIWbaJZcH/W0IqsUsbXXXsnXZl/al+bBFgqw/oWaOFB7AHbnZiJ5W9zZ
	 XlDgQQAPGMLwHUhP6os3UGiDDtXetaQ/8QN1pBu9SdILBO08iWkHaD5abZKhPhjI5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kFxDNEtLaJF9FbohY5ofu4rvslw1141Z4oiCfeRJ8oA=;
	b=OX5HjLItUMiT1rNQlLaxRQfAyV5jgpCtYYOs2j2QY+HyyJZX6nJ146ZUj7/n9aoYuZWF
	 3IWgaYt6+P8rnURgKcD3UEl4w+8DQDWy37+dqRlwyn3oV3752BK6hF+Pqd3w7hZBkI4J9
	 dkHvR0Alb5NaCvj5SNjSbPo5rzbj7csBnH/ACGAtfiAqh3MKhRuT0+oyFzLb4FOiEV/u7
	 CHlZXzWpupeBYIl/s7EZfwpiLI5q0lLwRyCcl490dpjrE3BdIxt1SxW6O0VgH92kbCRts
	 SNa3q2PvTg414hqa1ybgAyFNBbLFwkni2WHycOocGJR2BXQO6Py2KONHLmlC9ADviEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BaNVFCds;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2C606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C2C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BaNVFCds
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-188406bb948so1922638c88.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792992042; x=1793596842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFxDNEtLaJF9FbohY5ofu4rvslw1141Z4oiCfeRJ8oA=;
        b=BaNVFCdspruHH8GA8OXuVxcDRo7VDhd5uMp2O+cGb20fDefa4YtsvUN6OVZiIr8SQu
         +8mJqMDKykefwy6jzORLyZsw7Zf5Dje3yb5UK4BEFKGn+JU1NwWitamExQ+KX8I2jaOU
         urCfUjq7f37vTIcq1E46c2mxxTBTN9v2u1KfH4ToPmfQxVCu4B01/tSmvXlUo/mUDNtS
         gzF+iv7jOQooNRGVD2yy7iknYgLRdN6iOBjkJfgozq01QS/euJpAPzrQxck3l+y+jCp0
         L638W4cZYZPWxWbUuoBYDWpMbzqrGP8DXhEx83bK/Sc2Sdi8dWO8OmfeoCrn+01qm9Lh
         QIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992042; x=1793596842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kFxDNEtLaJF9FbohY5ofu4rvslw1141Z4oiCfeRJ8oA=;
        b=tjo7xAqSRnJwPtWDMfFjhOnAQMD8D0WPCLh45+9HwpuvkwMPOqs2tMUbO6hfBY3W8z
         skkEWUjk3oVpNDgjPWIEK9RsPHDSDd/1YGVR9O++QgxdwBksNsduSTG31exxlqaXuxGX
         +0FMkRjDkPPQv+sD6QI2O6f88QzgV6RVuC0m50CuSunlv1ZCebwnTIXv4kRyeqRD7vvJ
         H4UtTpUG8k6KvPax6MIjWFDuYFwuavDOA0DQVswG844D68t6BvaSBS9HlAq0JOWSdHRs
         k9vEcuWyRa1W213JqxDtvkKIIhtC4+tCCllW7/l0XPNpEA530JiD2WBMo8WMlPyFFapu
         ObBg==
X-Forwarded-Encrypted: i=1; AKwUvBw6g06VTG7VonURkH8qMDf7+d8rOZ3CBITEY/VU4iJB7t5jus5DB9ZfNgPJQgir+BgW8FHXNa0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/IIb7cpGbCtX+PsecMhe/A8EC/iiwSeTHUPqPsvm+hsbzT639
	UQroUbjXZj6J99qayjQc3m2hlaNzECVsugfq9vqWmo6aPzV3tozgTprzFLf/KLsXPZDKGtYf0d8
	TfZHa
X-Gm-Gg: AYBFou2JGDQo/lmFcVCiZkKSMv2PH/NCwMvih57IUBcY3rpdXsfOsLZUmtH9MkE3+k3
	cv0lvKD424L0Ojk0I9qDzz/HDo1yQ5Gdzkq7oi0VNCyX3ZFI1UewWPpmDTriyJGwQgRW3cGKYVY
	6QDkAQSpYfvG3fNSg/xmxnOczGtT2jWJxNXpxltgrUyzQEzOzKKxItP9mEr++NNImffIFf7QA8q
	m6wLL43xHY26mOn83k3ENdWFgg0sQ5VWSRdXBmw7fvlYn80EPzbbolJl5vig9W+y+TVZDmt9AgY
	IyhStYmAnaAbadQ0bvG3eRlsEVy9eMame40z4AXyEpcpZEpWGzOYXKV+ioxI0WE7amQU7fmUBIJ
	xWjl+In10MPPr0xyxMCapxqfT9g0jsDWz0J8pfEBGCmvmy51YbpfpY5rdXqBRvAESlldTeD/i1k
	Dvr01mAlmNIEun4C8gm2s0V8kHBoShFxXaJtJsVfTD+8PKzpEdE1jvwNpBdnNqM+HYQPmQ6iR0n
	5uqtSQrwQwSB8V6+Wv7bvdXU5XwUXO1bNQeV9nBgLW1CuidZ2HHKKd+g0GiE+LEolHXdqRqL/gS
	OZpOPZorGULGqE0nxCkKlj3jrk0kpXnUoez8Ow4smHeyyjO6uSdEMNHYQCRerO1jJM+ZQw==
X-Received: by 2002:a05:7022:418a:b0:151:2e62:fe6d with SMTP id a92af1059eb24-19935beba2amr11889083c88.22.1792992041815;
        Sun, 25 Oct 2026 22:20:41 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f83cedsm26765774c88.13.2026.10.25.22.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:20:41 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 0/2] RDMA/srp: bound the receive IU the target asks for
Date: Mon, 26 Oct 2026 14:20:27 +0900
Message-ID: <20261026052030.296361-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025114155.4007867-1-yhlee@isslab.korea.ac.kr>
References: <20261025114155.4007867-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The target decides how large the initiator's receive buffers are, and the
initiator never checks the answer.

srp_cm_rep_handler() takes max_ti_iu_len out of the SRP_LOGIN_RSP and
srp_alloc_iu_bufs() sizes every receive IU with it. The first patch refuses
a login that reports less than an SRP_RSP, because such a login hands the
receive path undersized buffers, and a report of zero is worse: kzalloc()
answers it with ZERO_SIZE_PTR, which ib_dma_map_single() accepts on a
virtually mapped transport without looking at the length.

The second patch stops srp_recv_done() from syncing those buffers with
ch->max_ti_iu_len. The receive ring is allocated once and kept across a
reconnect while max_ti_iu_len is taken from every login response, so a
target that reports a larger value the second time around makes the driver
sync past the end of the mapping. iu->size is the length that was mapped,
and the length srp_post_recv() posts.

Changes since v1:
1/2 unchanged. Dropped v1 2/2 (drop a truncated SRP_RSP): the floor makes
the buffer always >= sizeof(srp_rsp) so there is no out-of-bounds read, and
dropping the response would lose its req_lim_delta credit (per review). New
2/2 bounds the two srp_recv_done() DMA syncs to iu->size, the reconnect
case review noted 1/2 did not cover.

Yehyeong Lee (2):
  RDMA/srp: refuse a target that cannot receive an SRP_RSP
  RDMA/srp: do not DMA-sync a receive IU past its mapped length

 drivers/infiniband/ulp/srp/ib_srp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

