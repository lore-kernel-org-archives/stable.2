Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202971;
	b=YldF4PJVyut9L7HmDoAbjHEtnfDb63+oB40BCcVFaA34rcFAhqRNyi+a6E9FSxSpsWyb
	 sIAJkorWGjJnPYO9srUzb1Iq2llosGgdCutQt9bEhf/XXJ6GS/g9VsC1bgm4bASy4hilA
	 1LG0TGPbiImJsRt6NlbCRYESKAkKQ+QwcufYRiVgykfKgtWEpxJytPiD2279e+39syGYb
	 xcDVl7PamdJHavtMPIdkRW0BonS3BsQOR3UWF5iwJFmo+sceVFqeMopwASkdBVnOj9pbA
	 A/+ijtaFqFGXsQSJDVBJzU2NF6yv1EpRkFfFHHy6ynH6Qb8mmcsStbp9LDiIr/1h5qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
	b=07no1vJ/0rTMMRzY1IsVw2NHC01cQuU4Nkg1U+ooNUJyxcGlJYMw5osvghMWXT96GKHh
	 OT5tBmJAlOxID2IZY5S7vQZRtSfSfcDgoseHuhcVhfED4BVPuB7VUbPHLSwQO9iY+ZcrG
	 4x0ioykZO5UR0NWMWJwJOnBzqMPnG9ujCydBJS8NscBpgOBlwRXa71k4yYNuxVFWVD5Jr
	 UC/KJTIIhqP/72CMqe12bbnIWnAkMbliN3vWde5nC7qKmpksSOehjUiF3PiVSzhrw2hbj
	 syNTEN4Dx1jAFkdp4ADr5P34xHQgMrvBwjg49tpxvqflIGo7+cai7VeE8UIBfvUpBwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AMc/O9rv";
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF7606A6EF
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCF7606A6EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMc/O9rv
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-71b30ed75a1so802971eaf.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202965; x=1795807765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
        b=AMc/O9rvrWAOFSHNAZc0dEv5FdYm+9X8d3+iGUjnqCUmleO2ZoOaXnA79f2QfP6zA0
         0A4ZwFdx5PpMdIqbCMlzik05E5roocUnTUWgap9FrqK4nBdbDKch4p/jENyuBXwlrKAp
         Jrt3w46wyVyIsLUTCUKO5JfqAAsPy5anDy/tKp7xp5ojFRCpO5tsgrg6/WVxL1SUTew0
         seL/FvxrjA9arO+1xGAlecaMB/p3YeWal23LRSa/vJiy6cf2P35umEn3i4QgV457o73L
         BeO5mvZRLCgwwy7quIVn05j2JSz545+fhRj/2Y2TJH/szJMv+0NLPqOzqhn8MCLOdm1T
         RDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202965; x=1795807765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
        b=E+nSz4hfEgTZfMGLYE2HyWjLk/AXPFhaZjyv6BwSg/UN+Okrw1Fiy7B0oTH6owSf/F
         BfDEtMmRy1bAxBttBNFXi+QrcM74HC6h39dD4k5JFdSUzm6RBU1NGaGqBpJ2EG4o/GlN
         coBeQOzNfs6Kkav4m6c9Q2WB3IsobbYUgvP/Uzq7zxDtOahSkHu+N4u/4gnFU7WvKZnY
         eOx9j4bfQlYGSM1LNzUS4Qat0T4iKuFnz7C9Rqdq+eKMfMyfaNlP8O9Ei1gSYYJSh/LT
         LqEkuNt8zGE6OWycsZ40FfIOd43w8QsD/MAeH7Dig+BGwRp0qgW6BpyYTxzuNrBkuQfO
         yE9Q==
X-Forwarded-Encrypted: i=1; AL+hErF4cRGVVQDQ7Ul25rfuJZQ1mYRnpducdc0YvvpewEdEmyuyeG4M/cOZ8xZd61eCwTxWkG5uqyk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HMOjj7ThIaRf3mGmPMh6ZR8k5ihE4hkcshIMHjzqFe1tTpr7k
	2YPMv2j4fp6s1EkWlFbII71eXiLWwCUvVAPQS0Q2LkLqC1nVk7xwyO+7
X-Gm-Gg: AYBFou1a+7SDVEdLu2dg/yiupcP6HwzNk2usB6ix8uzwf8261bRXJfRGw90AOU0AsN5
	vbB9BPHDqn3D/IM7IY0sNFLcJm30Kp+KJNGugGkIXymPggh+7hiFOvPylt4CoBvZ0Fog8tap9Nf
	2KQk47dPeoE6kOfntnCHN9MlKtMlso5RoKDkyf/D/FknA0TXgPCcKt9MJgt6BF6dJuzP+coGg8I
	s7ZeQGzBoqhgyeav+PDO/F/jTa0vbzpiD0pywwNr+K93I+zWDSwTSsyhsfJrtU5UoWSGQziNqR8
	DqX4N9llh4sPg39zLOfZdpF8AjTg8MLk9pk3yex9UAbahnRsG6XuBJGxQUxoOo+W2XbSKopkFgD
	Bxc6srQNEvrHBadF8ltwdahnumgeWyFnOdg1ryAGZjoyiMRy4Msq914+s5k5za6hoMf9ajZlLgZ
	5H81AbLUaV5bYJLF5Mz/WKk5N3+2SEKfpokTO+NXO5enrkfGTIv4oCCFFj3e7+tiZZQy7lzwHCT
	IX3DZFiIhjpVUPoiHFDqvO7UQWnUrHNK0QtNKyGOFoF5oLo2gFMmY2gO/fieU17x4abTDT/xVxS
	ga+priiEcCuM0JN2Z91LzEQ5VXEY9kfJ9JeTx8J9YlKL0b6g4yPZBOwPAhhSF9y59H1d64kY5T0
	pVjkD1cniolHPjnvf7xzoEh3Fmw0uqiq8CHYL/9cVzTwJBc89Vn2DiiZ+Skcpfze1df31TqameG
	VXyRC4LvTH8YAgAuBTG1EN2muATCtz4BuHB9N01ZHTFVYXbrFL/5HY
X-Received: by 2002:a05:6820:c451:10b0:71a:f8c9:c6bc with SMTP id 006d021491bc7-71b39507d6fmr2684229eaf.55.1795202965405;
        Fri, 20 Nov 2026 11:29:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:13 -0700
Subject: [PATCH v11 7/7] dmaengine: dw: report residue for queued transfers
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-7-9b9166bc2cc7@gmail.com>
References: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
In-Reply-To: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only checks the active descriptor, so a status query
reports zero residue for a queued cookie even though none of its data has
been transferred.

Search the issued and submitted queues as well. vchan_find_desc() covers
issued descriptors; submitted descriptors need a separate lookup. The
status getter already reports total_len for a descriptor that is not the
active transaction, giving queued transfers their full remaining length.

Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7a66dc75c546..f9761651c7ec 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -942,9 +942,19 @@ static void dwc_synchronize(struct dma_chan *chan)
 
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
+	struct virt_dma_desc *vd;
+
 	if (dwc->desc && dwc->desc->vd.tx.cookie == c)
 		return dwc->desc;
 
+	vd = vchan_find_desc(&dwc->vc, c);
+	if (vd)
+		return vd_to_dw_desc(vd);
+
+	list_for_each_entry(vd, &dwc->vc.desc_submitted, node)
+		if (vd->tx.cookie == c)
+			return vd_to_dw_desc(vd);
+
 	return NULL;
 }
 

-- 
2.53.0

