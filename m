Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874791;
	b=krKWGVhjqSJ+21EuLMfzYSY+h3tsPTRO0eImnClSYKfLc8lxU63mywtRs5ciBy2Xu2d2
	 vxg572AI8SfkcKd6gNsBGjoQW0LCThRnfwJOmF6Tx2uHRtOEPde2t86f9y7cVEaCpyNz8
	 n6nuxe2RTUuMsCLqgJv9gyioZcO/ha1EnOG5ywEpaBOBu5vUbr6D7QrsuNmNBsgaD9bWC
	 6SAPvJl5jNYmf2EuQigYT3GBN2NiYQRf5Hh6TJAzZl3tzt+nQ62j9zuZcE8Jga474w/D+
	 s/sIA1lfMIF2penE8IQN3Ds596mIdkdPc+j2vs+pPjgayl1nRIbjfksRlUv4bwQA7yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Hu4rTYZRq8CRBWytQe/3nd1VmbMLjbiC2A6r+ZmdVf8=;
	b=OzPFVR6GvZM37U5Vv7fqnFME+zVlWhVgKnCTEhWBrCqiPmRgzTgbvVUfVotLQ1fWB0Tw
	 uXCdYROaQUTFH1epVEEPr0c9A5jU/vbnc6L+6EPdq7wijlFs95hTAcidN3RJuihXJoivo
	 cSUACPQUAVsAL0/gPgFQQZP8bZkSVWG/KrQjRyek+IZKQKPcalktMD3c7df8BLdedU+92
	 hwSvCzugQff9ZGvd5zhTBoGUdI+vBfTxYMUOzoyGC1gJvxieenwqAMMlZP+aAXyId1r5c
	 7lEfo5olTjFrrmBcdOX+Xv2KUqhVvLycSTDvcw1XKJgcFchb6Rk8ccmmX9vbFO/uY9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmp30UDl;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6C606A332
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 14:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D6C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmp30UDl
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55c35262674so66272901cf.0
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 06:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795874790; x=1796479590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hu4rTYZRq8CRBWytQe/3nd1VmbMLjbiC2A6r+ZmdVf8=;
        b=qmp30UDlRJrw8D65dtGD3Y4sLmXyuySPR2zFk4D4VglYBX1w3L9bsDC4lvVVgTKTDn
         0y2BW2EZ5jAwVsCIMh25KHvQWY15I6Ogp2PZepWQXDyyj8CPKDnovWRP1q1Xt3LOAkZR
         hAQ91GmjHVOkYlwar1+pq80tMUlQGAkIjY/maUd3pvOVNNCBjgB3fosVtA6IdxYTkIRK
         MlChkve4wIRqupfcCXDepISVUYgMXU3qrCInPK+WjqNamVprJN0yOfYJ6la2bMx/dWo1
         fjlwvIxVfeuwLZIHlfqEdEpDwfi8j6Wukyc75ui5zEhEZy47UnXbgz/g7mYPDfYRp58r
         V9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874790; x=1796479590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hu4rTYZRq8CRBWytQe/3nd1VmbMLjbiC2A6r+ZmdVf8=;
        b=mVRe8b9GolULiZAz+kSNsgvtZGw2xwC6mYZ2FRG9ftHaJqVxVl4qD0B4ytBQ/qV7K/
         /JWInLbT+DqMXDika+y1cuwwf8J1bTlf+y4jAVsQuWq1h1cfaCfqVtVQAsJ9En6PpWDv
         NdHwejbFqVJqLDDKYmZDEFp7bdOuwVMXLyBLoSZlwttQkp7j5iLdwUIOjAZ/EQZ1ynGb
         /VArxWOZEJmKmzJsszGI2RH+Il0ZUCS/KF+ic3mEgQI9y+8I8zh30dQ6ryei0mq60RSd
         GHR/mksX1D9PnyManEdj9eWtSjYDiyR8kWJAxmtbgobVud1NSZFbI6pMGWiVZjTADfKv
         MJoA==
X-Forwarded-Encrypted: i=1; AL+hErF87oNWxMB3ps79JGTUBDnVA/3ENbauVDMHceNEK4RGcLCv8W91fVN18vNcqLSFkLLtwD5JXhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ekXmRogVNKx5/3arSBdtWS9n6ly2jV9HuPMQEWSy2WxWbG4Pd
	5xDfHaT6nfQyFJ9zy7Baalsldv9i6XUsTv4iNzztqdg2oALotkzQ02LtT+oEjGVpCGUFpQ==
X-Gm-Gg: AZFdTZdCorwwcSSsh3WQjtlMLvdQYZ8OweO2aJShPzL28Qd44/F3SIgt9weX+oLTTJH
	DP3kU8v053Pn9AvotIT5Z/2InhM5O986sHB1PGJAEwrJnjfxCci+tgFw8b+eV0cKIopQ21xJvom
	ZJUQMnw5+mlASGp1TLedodcOKPLR2NW+zbxCto/z0gNbYY98/I4WQbd49p50olwjCZ9HkpRqPk7
	FkRRajfTGONy9HG1tg6D9sgfCgV1UKdzXXHXCjdJcHK9aFR6ynPzN9z4+1niwNhi0TFbzVaCKGo
	Rfbq5AbbJeevbv6HDkgjuTSY/1ZIkKxeOJqskwwytJgjf2ePOZHklSVgBy5pMe/kEmFldT8CHvS
	JaR25M1uuvnjFnkFHJiH9Zk1rr8kcj6JzpbWrhtac1Ae4OFLKR8pRNeU+WY5bl2AHKub0EJQeM8
	EG93hg0BD9kTUbxIOSQedQlRD+/LbRN4z73rpPX5eEPbakm/DTQS65tJjuGMAXQ+vgHfFNxh9mW
	btngha0jStt33eUzCu3AXVdHR/zTc2uxiI0v8PJUE6b4c8m3yWiHh4XRWJzlU1MKW9ZhkKj2irZ
	JB4Rp9J0ne7Rr8kroQL34xT1A55j6RInH9VOwemOBz1ICtTHqJi3AGKBzyxWzQ58R4PznvUZtzL
	JTS5Y
X-Received: by 2002:a05:620a:4056:b0:949:7893:397d with SMTP id af79cd13be357-949ba9b8ccdmr5414402485a.23.1795874788655;
        Sat, 28 Nov 2026 06:06:28 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a017cfb46sm1038426385a.28.2026.11.28.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:06:28 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nikolai Dokutovich <ndokutovich@gmail.com>
Subject: [PATCH 1/2] nstree: reject a non-zero spare2 in the listns() request
Date: Sat, 28 Nov 2026 17:06:22 +0300
Message-ID: <20261128140623.19-2-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128140623.19-1-ndokutovich@gmail.com>
References: <20261128140623.19-1-ndokutovich@gmail.com>
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

struct ns_id_req documents @spare2 as reserved, and copy_ns_id_req()
already rejects a non-zero @spare.  Reject a non-zero @spare2 the same
way so that both reserved fields are validated consistently and the
field can be given a meaning later without having to keep accepting
callers that filled it with arbitrary bits.

This makes kernels that already have listns() reject a value they used
to accept; no valid caller has a reason to set the field.

Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Cc: stable@vger.kernel.org
Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 kernel/nstree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 44e07d0fa8e5..ba5743dd4f17 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -437,7 +437,7 @@ static int copy_ns_id_req(const struct ns_id_req __user *req,
 	ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
 	if (ret)
 		return ret;
-	if (kreq->spare != 0)
+	if (kreq->spare != 0 || kreq->spare2 != 0)
 		return -EINVAL;
 	if (kreq->ns_type & ~NS_ALL)
 		return -EOPNOTSUPP;
-- 
2.43.0

