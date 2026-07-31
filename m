Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A53C2785;
	Fri, 31 Jul 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486250; cv=none; b=QhS+osr5hEi6myCE0FpABEbj2boOmwhJsGtU85+vCu79fBghUCzH5T1+M/yZX60ZZcq9SW/VAVFfyAVrRzIVFzOR2V87kbxO1Tqwwad5SqrdciziwcAiJeBHodVboh5Qg+X8Tb7B3NfyqqJBnIljTp0WpvnF/ZTCwK/+1z3RMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486250; c=relaxed/simple;
	bh=kVOJcr6CLzNZ7ouIBDOmh8hbPWaSW7xl9b66eVvmx8Y=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=S2L4roVzY0bu99NZ92i7mJjXwQvyddIcuP2kHyf7E5IwbAiImBgbr/P0eRvziKnKy1YDOS9MdzsKc5o7M4jMuZgyxmdrseV/tLP7UcvpDacpLFLUps59J3tlycLMk9EEemu4d9P/qyIEQZ9Bba0mvuCon9TkhrP/XlepKkiS6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fEb/v0Oq; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fEb/v0Oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785486240; bh=/YsD9IxKdcWxfFTi6jZZ7wue3Ex8dd88ruMot2jJJEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fEb/v0OqMkbY+tUfCXwHBWXkkeCYf2Dqzyp8Zk4nJ4hglqydMHjl6BM8np5CYOoHi
	 geewT0dTcJY00yVIR8UYokn0XOqxte0WTI+z9+xfp74+yUznuo4To3GsYskC7yCGCM
	 PXfPoRH2Ju5bHwoLlMbi6KES2+FsXaTn/gMQVUHM=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 5F91AC69; Fri, 31 Jul 2026 16:23:57 +0800
X-QQ-mid: xmsmtpt1785486239t49xddnsy
Message-ID: <tencent_2B643DA00931C32FA4498A865C0631416705@qq.com>
X-QQ-XMAILINFO: M8I/8MYFW72GqTHJjfBeDx3/lEPe2ifw4znEl5mrT9M/XBq1NzAMenQKsF6iCo
	 SY/dgqLo9Rll10BukohLn1z45xwP0LhZAPdM2z8SnGJ2t72dfC+l7J2tJqwkuuzKnam1d2Rfn7Cu
	 NQ5WyA1a3JphdtXk6qgTmbX7ePv/4gm9IxUw47SJAKdB+ZhrI0dh2qZUyNJ9n0TYsTlv/uPFL55F
	 ak8hINozdMjBPl5jqi6A25d1U72+lqRgiuJuvDmavzuopfSyeNN803u+dZqOe3bQavkHyfY1PayE
	 gEsx6kXS5RbbJBI8h4bQ0ogs72cVYnC4Wf3H5QhukI15eJij9+r4Xju5cr3F3bOxTie4jcejwM5U
	 dTFOo5eeIjV6zkgDsEspd8FLUyBNrV6ZH/i1H4gdMzh6i6TtQ05WwR/k8WHQkg4pd4sXGmvyqTjy
	 fj42/wed8QfOk7wH28g9HECMqNcefRvqSYu59KM4V0AP5azBXdapDY/KoumKSiwky8R7nGKUBVuG
	 gzUEYHn0J2+gHIi4bDXQPLO3AtLvpwIqsR102wI71jlswjHK95nYLkcxEsyX2bFQfbD2ql80fs+0
	 PDTWz8iILW2lxk2yUm1tFZ91U77O9XTnO7swURzd/aprZcdecFxar6yVDbZvBqyWgw8WIJ+Akp+V
	 r3mfEIyEDElrn448Cga7A6A8OU5c+/Kh6Q6HbBWreshcnykd/Jvv/C6EwLDSCHcbN1uJnPbsKj/H
	 ZqMHg7Damp6oM3c1hiKzbtrV0mRMFQmqo+v3DRLJp2w18XOwhC5s8dlyVxTCT3mQ1BbNknsjnZvX
	 y6IPVoFWkVik4M5rE+XyIIrkRaimC8zfSLibYdzqLA9Phjo6jKE2d3ncubY69PJLGlKKBP6fHM3i
	 R68TtirrfWWETceJEShnSPovorD2LE9fR+j0Jc4/N4sX8ENX1ppK7bRJ/Fr2eyMDERFyKo587Xcn
	 ykrpBFgCQM3mQLtVeNmx+IcSaTNiGSbivOqQ4bEVedyWUfpo5hKoLiaBJLYPFTV0ccT8YU99suyX
	 QpkpaV3vqdqPh+Q1tyD22s6++PdmlnvW3KsymRF2ICvNKbXcbP2/L6awVZbSujH5AdV+NC6F8Pu8
	 sh+HxXMIjc2BXrVgr/GprCOQ/fRFe9J+7Of7/WjDQ6WmJNbZvRM8uDtLVGfB0n5yNS3uCB/rs7Uv
	 QCLXIHmRC1MmZgB+YqNdmAetra
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 16:23:54 +0800
Subject: [PATCH v2 2/2] can: dev: can_put_echo_skb(): free skb on invalid
 echo index
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260731-master-v2-2-204d772f2e36@qq.com>
References: <20260731-master-v2-0-204d772f2e36@qq.com>
In-Reply-To: <20260731-master-v2-0-204d772f2e36@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

can_put_echo_skb() consumes the skb on all paths except when the echo index
is out of bounds. This leaves ownership with the caller on -EINVAL, unlike
the other error paths, and can leak the skb if the caller expects
consistent semantics.

Free the skb before returning -EINVAL so that all return paths consume it.

Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds")
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v2:
- Free the skb with dev_kfree_skb_any() on an invalid echo index.
- Collect Vincent's Reviewed-by tag
---
 drivers/net/can/dev/skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index d7b5a5d17ff2..c996cc2b417b 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -54,6 +54,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
 			   __func__, idx, priv->echo_skb_max);
+		dev_kfree_skb_any(skb);
 		return -EINVAL;
 	}
 

-- 
2.34.1

