Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6943E9FB
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834081; cv=none; b=oKu5Z+3g0LqnZTabKMUJe7oDwkxfkKoph02+uQVA23eFQMN+udanuBinwn1RHnDxya8cq12P5fROWp30iXTps7f+TfNBHJ1qsS7fp7SASftLsqiL4iYrV/bu/PgH1r6iGVq1v5/2m4Ym/N61q2lRyzV0pNXw+vCXkYR3HX638Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834081; c=relaxed/simple;
	bh=cKn0rvdC49BIcqAimFO1T40WDQRqjLgqEK6HkR4ZC2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fzq4UJxa62ve0cIKKha9RitsgjtXjI09a3sW8TrbQudcVCPOTyG/pkpAmTC1rzFejkTZJwCN+2ACw5kp6rayMQDrfHg2GeeAvSniE/z3IXlyY4fjBGVUlN92lHYCOduQzIXrvJukmlivCglG9YWZ4+k+YEwGKdZRwZyHwFYLRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de2h0YNR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de2h0YNR"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485ab7c382so457644b3a.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785834080; x=1786438880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALanzQpzebmmM5lW2CkhaK/fD5aNgZLXF16Jkbg/hKA=;
        b=de2h0YNRZgML5tODJM0Kz8NSQ/lV8Y8LLq5SmeIlC8NPdPgZXSo/3BE/u70FKeaglU
         3/8FlooGX6pujskVZVJ2wDmapHp0Ggu99ms/Foxj0a6bTKhM8BTDWcMrydcpax0xY1mz
         TcoYV14OLbP6VMuGmEB5IjDc1c16Tip5SGGOPvBnP+CN6hiTdlB0r5SQKvWR958f7wo6
         h2mEWgpU900dLT2e/snG2LZ/WQhUtQSMmhIxxiAz9aV/VEhRJunr2OiEDwC4q1fPLKz5
         izNFZS2l0VFZcUIGO9gzBVmWaLulE/ep7wI2ISiP/zTu8rHDnV0sJwXQcafuUNbkQVe/
         qS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785834080; x=1786438880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALanzQpzebmmM5lW2CkhaK/fD5aNgZLXF16Jkbg/hKA=;
        b=Pw1Vhs51FoXiDJhAuBKonvuCTzMetP2Csj7zxBOHj5/cSkuksFHnv9SEWfuIc0tqAi
         lYAKSxDHHxn3xhOn6zW1I+5x/v2px1uWDTxMdwdZZc0azxLWl5KMG7wF80s6cyP4meSQ
         UpjyFK6EnNFIKrg2wAjs4Z1mHznsKdV/9g/GJaD4fVV8zXoDhrm/veoDa7O6J1106wUy
         WGc30ypxp5wtGxdhnSQ+ec/ztUgzIZLG5cEnibIdS5EyUFaeIUownq0hviNleLEhHuHi
         Mortf90iDTCoVaMFVFbxQkmGf6hBU8MKg3Q+HIGIqIkXNOxiBN38YWI1N0oMqncLVKJq
         Iygw==
X-Forwarded-Encrypted: i=1; AHgh+RoZw6pWvH9HHgMEPNPmOPeZ4eBgvE3K9qQ5BVGxolPow1iHVmGIreyJJX7JD0zI2p6aTWdX0Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6FUOm2Pk9pQo1tsxyEPN+Z+zrkXMwNXvCCwtKM5qsTkoNC0A
	NZQo3mr5yKhtpgnDQjg891ylHV/Rxx+W2DEnPkeqQysmdqOGOAiOMfw22IR4c+T8
X-Gm-Gg: AR+sD10Rv91FbNlKONhVavFyDQhny9tZ0gix5MtDc+EhrFKc3ko598YO9XfvhUBtM9+
	oEvRUTDmZ3gqrQtlIm6AYqqcroH1M1yfzxbuZ1G8aCyL5HOW6JqYNOXR7E2hcqti1nsU8+egqge
	873r0QFdmWQxMqXonGT8SQ3G6Dsuifmp8f7buAMC5CY9sifse+5CZWNwatYGm6qJotpEqW9YJJi
	gLElY6IKW+Y2+Vnf9yOjfW5nWh/f/qmKVDnjqBmFC/jOlW87rZde+dLNVGqM93smfhFOGTdDC41
	ZhNonpi0t8rW7Ov7LexM8hnqxzvgomcZLs+UMNa14Dr8qmME5HUm6XMCeRl4FeiUSgbm89F2Pwe
	TX6R+2RPNsSz0huKY7avfs83IktcAfYcZ1doANNaXLp2goxGp1fCZUSpRYdktyVBN3rGkUUDEyE
	+WR1ttTgfZYHABPOfobYr1J8bYpbiQ6vnyNjYoYj27p9aovOXF0qbBukoDzM+m5RiTGCc8d5doW
	YyVbI+6c0RTot87VqElH1wDeKJBknKiX78A8uogXXquS9qFER0=
X-Received: by 2002:a05:6a00:3d44:b0:848:3dbd:5cb0 with SMTP id d2e1a72fcca58-84ee48bb3e6mr16511860b3a.2.1785834079603;
        Tue, 04 Aug 2026 02:01:19 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d45afsm4813032b3a.41.2026.08.04.02.01.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:01:19 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v6 1/3] net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
Date: Tue,  4 Aug 2026 17:00:14 +0800
Message-ID: <20260804090016.33353-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804090016.33353-1-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260804090016.33353-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

dev_validate_header() reads dev->hard_header_len directly when
zero-padding short link layer headers for CAP_SYS_RAWIO holders:

    if (capable(CAP_SYS_RAWIO)) {
        memset(ll_header + len, 0, dev->hard_header_len - len);
        return true;
    }

Packet send paths call dev_validate_header() on skbs whose headroom was
allocated from an earlier hard_header_len read. If the device is
reconfigured so that dev->hard_header_len increases before validation,
the memset writes past the reserved buffer, an out-of-bounds write.

This out-of-bounds write is masked in some SOCK_RAW paths today because
the same concurrent increase can first make skb_push() exceed the
reserved headroom and trigger skb_under_panic(). Remove the zero-padding
branch before making those hard_header_len reads consistent, so the
snapshot fixes do not turn a loud panic into a silent overwrite.

This path is only reached for variable length L2 protocols, where
len < hard_header_len but len >= min_header_len. No remaining in-tree
variable length L2 protocol implements header_ops->validate, and the
CAP_SYS_RAWIO bypass that zero-pads and accepts short headers has no
real value beyond allowing testing of intentionally malformed input.

Drop the CAP_SYS_RAWIO branch. The remaining reads of
dev->hard_header_len in dev_validate_header() are comparisons only and
have no memory safety impact.

Suggested-by: Willem de Bruijn <willemb@google.com>
Fixes: 2793a23aacbd ("net: validate variable length ll headers")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
---
 include/linux/netdevice.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..9a770eb823ce 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3531,11 +3531,6 @@ static inline bool dev_validate_header(const struct net_device *dev,
 	if (len < dev->min_header_len)
 		return false;
 
-	if (capable(CAP_SYS_RAWIO)) {
-		memset(ll_header + len, 0, dev->hard_header_len - len);
-		return true;
-	}
-
 	if (dev->header_ops && dev->header_ops->validate)
 		return dev->header_ops->validate(ll_header, len);
 
-- 
2.50.1 (Apple Git-155)

