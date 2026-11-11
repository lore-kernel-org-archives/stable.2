Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409429;
	b=G2/3ycoswAI2CkjIFhoDgWDNPhD88fP7PFMsRD5T3IPzrdK61cHUFzrqJ8xaV7/UYBUS
	 QIEjuqbK5Yd9iJstAVUoiIaav2ppmHqc8nLhOxZP9Q7/URi+bJW/nrEW8Q6c/GeTIthyY
	 aIUGEF4s4X+ja9KWQVg23vtxXzpBTSM/1A1UI5OoNRPcNIfe9pT4H1ILG4u1+kAc4OeG+
	 74/RB8T7JvULRSwy+TBOa1xc+DKNxTU1azz97xbTwWfykFrxgBhMWZ+A0j/YGOh0IEUxo
	 j/YIm6k3/cUh6sJJzGTLvxt3I50JaXVRpzBNWywHtKCsaGWGvxRBn7mWdUYuFX5TP2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H6YE/T7yLPeTJhVqXZ1rFvKKGujIr6rV/dTwZzX1uOQ=;
	b=IReFKajgI7M85//dIl0sRluOeMSWky4bCQKkfT5e7nTaSQ8pFEGy8oFJIWSm7/y6G731
	 GkL4AVpnHsjWyym1/JOe+lQvUKrcIdMFFYI2dyR3SCrL7HjlZ8w/PSZ51Z7CIq8llNGX9
	 eeL74LA+Hfg0Zl469zE151ijnCEqPqSUEN1V2GmamnSRpe1SrZbQt6kEHRp1LvsbpFfkE
	 jLmyWykN2DX/zf6QBrFDwe7zsASlbeay5t5KhkflWFltIbg35Ij11jUVmJFocHGseghc6
	 36dedalcYGDB/6eT/zIi6gEAbdFetSE+TMbsEPEF01p/HmMKpad4BoD/deg/ypMtrAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaO0e6+S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2D606A882
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaO0e6+S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB53B1F00A06;
	Wed, 11 Nov 2026 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409429;
	bh=H6YE/T7yLPeTJhVqXZ1rFvKKGujIr6rV/dTwZzX1uOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PaO0e6+SZT+pUsv3eFuFW9cBmqtYgvlYOXw7jv4W6106VYkj0IBNzQZjfdYXXUqKm
	 LiwTNy1sDrcPTLCKyM7+Z6627ddMNT1A8tf+IsdYqX4wvUs5h4p2HUpT1hSaNqWoU8
	 db5HmGLUvuAc/3dU10ETbG2jo2OZaQd6k/xa9+ttQhdTcYAB5icdLsoRvaf/8OsffS
	 XaTiCQo2qcdx8eqIwi+L2w4I+caEZgv9PAUKIxzc/c2e1bBWkPTz+IbKkHaCe43Vcs
	 nos0hDFH0gWT6Ivnheb8VWT6pdqGjaOe3lpJaSVgBFHcOmo5QzXHHAbwMFP+dUVtZq
	 QRVYfAon3/9eA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: serial_ir: Fix race condition where timer can be re-armed
Date: Wed, 11 Nov 2026 10:03:47 -0500
Message-ID: <20261111150319.2466634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051727-failed-6.12-d74ac4016ba6@kernel.org>
References: <20261107051727-failed-6.12-d74ac4016ba6@kernel.org>
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

From: Sean Young <sean@mess.org>

[ Upstream commit d74ac4016ba64cb3b20f395511d0b18025ca0ba9 ]

Ensure the timer cannot be re-armed.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adjusted the replacement to target del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index fc5fd39271772..f6702b3df9a03 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -798,7 +798,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	del_timer_sync(&serial_ir.timeout_timer);
+	timer_shutdown_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.53.0

