Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994084;
	b=XmXWnociQ858As+35hfEqpeeDSDoZ8Du7FAdIlEZzOcWRPuKWmeVTZA7dU53D7nzxRLU
	 poEsXs/kOo08x0+pemzRlHLvGCrw4xr5one82xkvj8URgm/apubSdXv6KxX8rzryri7lP
	 YsGJ/Ru6eknkWWgkINMlRWFei8mhzUvyq4DwFDt+p7uuW91OzIfLacsWa/4Xw4EVgD+rT
	 G+XcPm0zClOKsgeckkrU2IA+SdUx7uGq4gGgo6a3JjQj6p7XSlf12BsBwp1SD2MldQNGU
	 /zJTpPYrcvI+bw7O5VRUucqgqOL+p0SLyzm5yRsj0DYZZUuoaq8U9sUn0Brco74t0DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=csphFTdpMBTVxUq8xSOjb1glIePwWhBgc2G/OqCCfTU=;
	b=J9AjW0G6eGLKsHkm26druusuO+SEgrYSvmsSfmkWSaCK1elAlguIkYaXdcNY514nLfj5
	 AzeVKCfRWcLi76U0dsGQNmAwe7mlWYR4qAxq3QulPEcCJBWS4tcA6uI0Cew8X2rrbbISy
	 dpXCqYsEubmCPRDShd76fCKJPVtzIYGSHPsDgUSYgpRkO8U1EjtRq5OnKPHFFM5Kj7cj+
	 rD3c4A1glm4w4SrrJppv9TQMQ/haNOObTRMDfswvuvI/7EL4qxasvLCJ7oTFJgtkNVH7Q
	 9VL2bCymTUZ1LaHjB1GWowWwsWuHPtyGelj3LFHlEbZSwtOjyEJ6gnUhfLfxNQKYUxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VfDn5U2V;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939A606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3939A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VfDn5U2V
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4824837eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792994082; x=1793598882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=csphFTdpMBTVxUq8xSOjb1glIePwWhBgc2G/OqCCfTU=;
        b=VfDn5U2VYNvV56jVfnCG8y6ecapaC3HonQmStD6pBkbEAl0RLz5wg3JDXS9n+l70h3
         lS70Ph3nrjso20JwYz2NZAMCPQJQV4vxmLikdYZhRIVxQ3mzssPNoZtgMt5WwJ1jeevv
         DL22UvA5sJ4T2xY1eAWfUei6w5iR+OH2D6j1o87XE3asVy6QNLWQ9ItpUNrbfl/8bq24
         kbx6UQfTHUsY3eN78kp0Qbz40Ps7wIrJn+o/CGam5nN+7C0Y90DIYgro4pBL4HP8f1Pi
         JJu+e0wAbr7gObXeqRvW2hTrE0wLJxEnSc7roEFnsuZS5bCgn/HqY5vMtPhMVLDWN41/
         ZosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792994082; x=1793598882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=csphFTdpMBTVxUq8xSOjb1glIePwWhBgc2G/OqCCfTU=;
        b=wNvQ2YQcfIHUY2L3UtwxULTwfkGLHCul8z82AaEpe8lTVHalGDfwgNb4TSTLBW7ANo
         XhNt5M4shBGbbnM6f/IAVmtuxMg5VgxpXRmSv6tCkjVctDZqLnH3D2FeMVCAE+knonRV
         baYi5fK6htCxRtqtmAU2xtMDYuhL/B1acHZh/9jMvuk/2Ayii3qIn55+RIi8M2yiAuUB
         Y+YMVXGa3SK2EY6ZCFdgKnLwKr8RTUXri6h4DLhZbkKUAluyTn4yqI8kszsCrCpc5AAL
         10Vygeolz5SyhRQb+YcWrns7R5GxUq+p2zTwaJQ1x7kPmqctLyhWwFEi09NjKHlEBCE7
         Egrg==
X-Forwarded-Encrypted: i=1; AKwUvBxZqiWRTx48c6EsXmAMQXPSlrtiuaV8ifJHwZ1ZzU0WBVpPiPLrABA2f39nBgHHw8GyYEObgMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqQK0jvyKVEZl61+1C1wISeXiFWdHiJxw36dUCyWr4BUOBGXye
	AvYZsmsXjmzptmy65luxVtqF9Y+DF02JRqZyo65Ccd0iLT1ZrCnWjke1E6j3SocBbEg=
X-Gm-Gg: AYBFou1nlA9X70GuUo+MUTGaRaym7rorSBZy/K7UMVk4br6TW7yJFLUxVHeVUGb/WBN
	u2xz1ZoUO8wMhC/xAqMf+bIBtIFBqLn6zaBZ/WSg0p0yfmgmAGjE20pZUuPEYrfdotoMiuwqNb/
	fxPMoVvdKH53PPSElOv8TsA7rUjzLOwOJN02ZiHOVxIoo8P5tQrqGxIsJXKK+S8HnJJKXHHldFh
	abndGSVE7fKMBprvrmJxekDzgqMDvMuP+d8HwD4i+9osAbzChUJXY+Todn4+lYrGAdR+jxWdw2u
	IAHBy+yx0ILNPPI6p3NOwcPuGDHbkAfCvSuhWgEH1TwWJBJsWxzH4BhRLAtqztGncK4merMTHaG
	00caqp/1RGtoPsd2wdWut6as/ud4Thf09Igd6pzGxyYaX+/i8saTg3rhV5ecoIhw61JU9n5Ln55
	E3NYeosmHOkMOQFGTDPsoakj+jWiOIkprgKxkA6ngDUG1fbv9bMnBDytHGb4F6WSY0BCs3vTdp9
	hyCwcVBjR/9bYi6T9BaCOhnTvhjnXYtDVK0/XHgkFrzteHV3YIJrRb/vOtDUljwRMy/WsSP0ZBO
	qJVL+WbCzVZswFzgEY+vzfU0rDDS9/COiA8emW4OPJFOYvXh
X-Received: by 2002:a05:7300:ccb0:b0:366:4c26:2968 with SMTP id 5a478bee46e88-369e84e560emr9111160eec.26.1792994082149;
        Sun, 25 Oct 2026 22:54:42 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d845ddsm22290613eec.11.2026.10.25.22.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:54:41 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 RESEND 0/2] RDMA/srp: bound the receive IU the target asks for
Date: Mon, 26 Oct 2026 14:54:28 +0900
Message-ID: <20261026055430.406487-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

Resending as a standalone thread; the v2 I sent earlier went out
In-Reply-To v1 by mistake. No code changes. Apologies for the noise.

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


base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
