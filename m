Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBD242D97
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743575; cv=none; b=uv+IOKYcvImMgTIlC6FMKvBh9QW5gfZLc/9e/dvyxdp327vf/ZXk+KXk1wagb0cmJW790gEawvRfJgOy8JXqRNz7JcoNYkAtShKEJKwKmezS/Vii69MnXhnYSF5xUki5VmJaxsIcqpHCEdovYvkYV4bKHAtX4m6mdUroZl6qoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743575; c=relaxed/simple;
	bh=OzkT4mDFP0XjS0I9QKkJ+r5c2Uq7+gyJ+CLMbViBigY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLhWbuOy1i+3KRSqcdIjzxZTje7y0A9B5G5Wbn0swa/HQrzM7HF8xrYHvznS/CmEt6ti3B23DZN4vChfQ/CQA7IEcBOUxEtMBe7g2Hstdj4QJLzfYD9KtmvJwpJhuFldueg6nU1azviajAQ/DEW9jTAZCVOEf4SzZcqNqsKDnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKu/Zx2r; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKu/Zx2r"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4b940d3d7so406247a91.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790743574; x=1791348374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wclsaoUk0/D0pdgXhYjwxz2clMPb6mstI/WhFlPdig=;
        b=EKu/Zx2r0WfVav4+MaAFlD0cxn1Q/nHliNn5q/89ZXCKVNiLJLwURErin2/jeyYBO2
         VOyYmhxNr43m+9c9BxmB2AH1mVPzmBWTKuBylko8jgPhEREoXKXY5GJaZ7jsm4D5jbY4
         3s7Guxbv9qukXNlFXlpm59hWBvlITlnjOpn2Wp0oI/8IqmYdX5IXXkNCSZhszZM2MrAj
         hDdc33Uo9NOv75kOG1ez1OPNMjIY3IuR9Ph8xQlQ7l6birpQfX96nC0WvoQbxccrN/WX
         ZPiRN22cgoltAzZo8qt7u6ypAWuenaKXHkQmbDDZ1ptIosV0UtWCquNgxKjPTSYrWh5t
         2sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790743574; x=1791348374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wclsaoUk0/D0pdgXhYjwxz2clMPb6mstI/WhFlPdig=;
        b=suiopXMgOIL7CJmpMjdYrgfzZWus6DEqnWR847Q3c40On+iwtfukvyrWXzKeuVKDcI
         E46TbNJME7L3oYfCjFST2pStZenVOHj1l6sCyB8KIGLNfOUlFMmwcxDmYra6bCiP1x5f
         +442+yPQPi5Ahxcy4F1lJ96Vs+E1qFIVyJGMeQjGAcvf5Whx9Ft/sycwl4t0UiNssELD
         WyR8nL+KLGwDoTd4SA/LkTHgoyy8SaWziOHp7MyuTQnrY5wxRF0/vr4PTYxAnS2xvFM8
         nSYBtJZjHFM37afllQJ172HAkx6+hU94baQRUFs7o54rbmRIqfUTbcsxC5zh2Y+8Ge2M
         SEIw==
X-Forwarded-Encrypted: i=1; AKwUvByL8Hu2uvpoidG2p2vYga8vwaQ/1aAG3vUZUy0xBUz9+8qd7zhG6Q/Qii7M8HqceePkiNeZDzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoTB9fo9A1+4qGkmG3SvOca+f6ZIya4gaRT3GEaTIMlfVuNVCs
	TJk89Iz8qCDox+TdOOZzHedUjQWrm9xSIf16ld0e8zp8vl+RpsgvInQcmnnZgcXo
X-Gm-Gg: AYBFou1ph6/lbtzO4qwD2jMGtE/koBBzl30KcytrmI9WLVyiz6Lhh9gDTKlSn3rbA2l
	/BDJxLv6KBiv9wYJxtIbME4+JBjjWgymdGiieLZj3pj4GhkzkZxvUxUdQOqWmEU0bjX/i3U1HKX
	H3BDihArsQ0sioLAKwyZ33CBwt2veD/DkaElhpSjTDG5QEA5VSuVtRScaeio1BInvfyzy+cRdBI
	4GcSboUBj3uTmcnPf+Vn4iARA/MRWZ0YlwyD5jTt1fPoQG7EqAqddwmu5GLbr43uSb+Hi/ltt8i
	ms4qhzcnraR0Ny/3LTRyhpSSb2kSlVddVAmgbzQyvjitgCOcZN54wT0fW2jziipVu+YqwSy5Q8T
	J8XC9pmLcBUw0PDOIw/bnLg7xH8Mbsx7gm0Ob0ogNnGkVD3vXymAbBvLHQKPd8ETOfff/Gcg7Xv
	N9hDsQwdXGSeqd71hiyuR84aY+P887aYxYceBfsRf2m55bcdapgAhjhoJ8QwB4k0mSWLDtOouf9
	yQVIZf5Ji6Q00AaZKcKIOlDtel23MhQic1VMxULZmYPJDiU1E+CZj4SThrwqk8RVP1xjNSvb5OH
	K9GmHMATQA==
X-Received: by 2002:a17:90b:4f4a:b0:39e:4c80:f680 with SMTP id 98e67ed59e1d1-3a4d1544fcbmr259431a91.31.1790743573545;
        Tue, 29 Sep 2026 21:46:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae9ffaesm1339773a91.16.2026.09.29.21.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:46:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net-next v2] sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute
Date: Wed, 30 Sep 2026 04:46:11 +0000
Message-ID: <20260930044611.204739-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an SCTP stream output extension structure (streamoute) has not yet
been allocated, sctp_getsockopt_pr_streamstatus() sets the local stack
variables params.sprstat_abandoned_unsent = 0 and
params.sprstat_abandoned_sent = 0, but then immediately jumps to 'out:',
bypassing copy_to_user(). As a result, when an uninitialized user buffer
is passed to getsockopt(SCTP_PR_STREAM_STATUS), the kernel returns
success (0) without copying the zeroed stats back to user space, leaving
uninitialized data in the user buffer.

Refactor the !streamoute check into an if-else chain so that when
streamoute is NULL, params is zeroed and falls through to copy_to_user(),
copying the zeroed stats to user space and setting retval = 0 once before
returning.

Tested in QEMU against Linux 7.3.0-rc3 using an uninitialized
sctp_prstatus user struct passed to getsockopt(SCTP_PR_STREAM_STATUS) on a
freshly created stream: on the unfixed kernel the user struct contains
uninitialized stack garbage; whereas with this fix applied, getsockopt()
copies zeroed stats into user space and returns 0.

Fixes: 28b7eab0f910 ("sctp: add SCTP_PR_STREAM_STATUS getsockopt")
Cc: stable@vger.kernel.org
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Re-target subject tag to [PATCH net-next v2].
- Remove redundant retval = 0 assignment in !streamoute block and fall
  through to copy_to_user() as suggested by Paolo Abeni and Xin Long.

 net/sctp/socket.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..1aa475d9dfdb 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7569,11 +7569,7 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 		/* Not allocated yet, means all stats are 0 */
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
-		retval = 0;
-		goto out;
-	}
-
-	if (policy == SCTP_PR_SCTP_ALL) {
+	} else if (policy == SCTP_PR_SCTP_ALL) {
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
 		for (policy = 0; policy <= SCTP_PR_INDEX(MAX); policy++) {
