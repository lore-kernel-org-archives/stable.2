Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725D429CFB
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064615; cv=none; b=Ox4yu6tYX4B6MSNqloZc4iKhaDeCtY1q+PG915inhloDckg0v9kE2NnM/1aMnmGGGpTpLno4xYPku1cqdTaNN9OXWDZwBoDhL8vapr1flQ2MqaXNFhBOEByxi6KjShbQ/SaodIfkEZYj7cBaeTXSCsEY0VQHIoqYybIcMn8cXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064615; c=relaxed/simple;
	bh=iNCG1tIjQ4FAhrmOPyPaT5o/A9S+6bSIhfZX0UljTq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DWPKTKlX8bTvoohbmIRhf8YGqAKdeSZqZbv1cbWByTTNqyALPDYQl934QxmFBh8qSxgkUzdXgAd2ReIkS4eZHBsEWTyweS/whYRm10yIdXiiu9Vv15HsQEMOB7peMZhkNgR47rfUIuPMEgQCe8nwvTRqRXAX+M9duxNg6byPmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRbpMiyy; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRbpMiyy"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7ebe970a21fso5483423a34.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784064612; x=1784669412; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNz8QnvimWhRk9ABRRHHoslDhiyj5Y3yR/R74w8AAvs=;
        b=tRbpMiyy0fzs/cKzrC+VPgs/Jdw77LAiW1AdMe4icD6hrn1xMTA2Bdix3tlYb19iDr
         xf1BFC7k7WuPgb/jJgsFBNEoYIGlbN6zdGxBXwSWAYlhxeAuXnR1pNKo4JU6Cgss5F/j
         t+GfK9lA6Eoy6C/pF5WvLkxbU+ESAIcXQi0Mcgwloy7DLSj2a2TwsjVlei/NnvabIVnN
         ZoMpShkKGlHz0x4toOBs9Q6DlfJhwT+U+r/UPcuf0mXNdti2dSrxQHAbFltyrqKUopp2
         kzKrf8TyoNg7NsHXgZaeEPdpmLBHr6F5RAwuGIlxVNZUr/w874cutSWha735fW0GyzfV
         rWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064612; x=1784669412;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNz8QnvimWhRk9ABRRHHoslDhiyj5Y3yR/R74w8AAvs=;
        b=dl1DgeE75zbqMSjA0Wpd1qreAkjkSY0reJTTdikAiPOEcyEf7hHnubljUvNr9Xq8vh
         GJrjj1ouAEMADXr0Zf2fPg8eT3aOQJ0ABIXxWuyV7h2+AZIO/RtUE71V2unaDzLcJalr
         LSlPdFFdGakduiiLkwm9GsF1IqmlHCSodJW4Ec9MK/Q1alNxo9eza3VTCLh98nSEF86a
         iW6HD1d6PY2/6zDOejCaneGfKdT1b6BXZSSoJh2WLD34nxuPXD1wGmLEul8440P52vmP
         KfH7Fvf15CxHMYSGySNsWurcS1FG+sWA8M55OSE6j3RWZ80cL297sk4fn3WW6lPFbUCy
         EI1g==
X-Gm-Message-State: AOJu0YzbSlcJ3QPsTfzvORwu2AgdRKSzSdHezFUWW9UOeHnSRj4ELci+
	KgUIjfORQ4GymrO0w4EfH7yjlmKuY17kConeMD3UdgqCXio3kXkGi/E3Ee0tu2L+r45l/y06urz
	Zkwj30J/C19tzwlXJWjNTuKrlWL3ap9wxoaUVV4z09e3SqlYa8UtvlzNn/GBiBEVb32KfBohF3O
	eC7WqY5iOKS1Yb6v9m+6fV4ZIEcBlv3iEfeiOdHyMEIA==
X-Received: from iog26-n1.prod.google.com ([2002:a05:6602:80da:10b0:9a4:db9e:e8a1])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:6aca:b0:6a3:84e2:975f
 with SMTP id 006d021491bc7-6a3c61f8a80mr3197339eaf.54.1784064612096; Tue, 14
 Jul 2026 14:30:12 -0700 (PDT)
Date: Tue, 14 Jul 2026 21:29:58 +0000
In-Reply-To: <2026071415-blouse-plunging-e6aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026071415-blouse-plunging-e6aa@gregkh>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714212958.1692499-1-nkapron@google.com>
Subject: [PATCH 6.12.y] usb: gadget: f_fs: Initialize epfile->in early to fix
 endpoint direction checks
From: Neill Kapron <nkapron@google.com>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>, stable <stable@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

When parsing endpoint descriptors, ffs_data_got_descs() generates the
eps_addrmap which contains the endpoint direction. However, epfile->in
was previously only populated in ffs_func_eps_enable() which executes
upon USB host connection. As a result, early userspace ioctls like
FUNCTIONFS_DMABUF_ATTACH that run before the host connects would see
epfile->in as 0, leading to incorrect DMA directions.

By moving the initialization to ffs_epfiles_create(), epfile->in is
accurate before userspace opens the endpoint files.

Fixes: 7b07a2a7ca02 ("usb: gadget: functionfs: Add DMABUF import interface")
Cc: stable <stable@kernel.org>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260619040609.4010746-2-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(backported from commit 82cfd4739011bdc7e87b5d585703427e89ddfaa5)
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 1b9f3b2953cc..56a8323949bd 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2363,6 +2363,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
 		else
 			sprintf(epfile->name, "ep%u", i);
+		epfile->in = (ffs->eps_addrmap[i] & USB_ENDPOINT_DIR_MASK) ? 1 : 0;
 		epfile->dentry = ffs_sb_create_file(ffs->sb, epfile->name,
 						 epfile,
 						 &ffs_epfile_operations);
@@ -2450,7 +2451,6 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 		ret = usb_ep_enable(ep->ep);
 		if (!ret) {
 			epfile->ep = ep;
-			epfile->in = usb_endpoint_dir_in(ep->ep->desc);
 			epfile->isoc = usb_endpoint_xfer_isoc(ep->ep->desc);
 		} else {
 			break;
-- 
2.55.0.141.g00534a21ce-goog

