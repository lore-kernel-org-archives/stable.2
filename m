Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8B420475
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971748; cv=none; b=sU/md6msMrrLWgohKShXg5NR3Pe8Pgqn2ZAetQ8Bu+u+c70mC/Lfl9+dzNQVFd3fcrXkh/x6cT/d41AIuS75CDkUvMneMohVNwADna07TasLwCBc20gKjGFVtrCiMxdi3VJQKyP22+gMlhPyewhvjrA7jqHQ+DedHcyRZW5VruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971748; c=relaxed/simple;
	bh=gwe8RvO9NLk/ZagXX1GC3BDr2ntra7FrFYCED0PFHUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp/iKmW0WTguFOVnTva4h0f8cu8OgEC9xBg+M87S9jQa8yCsII2nN7F90wyqDH32IYYV6CE8GL5mZ17yhHXeTTTfYt0V+BvFt5xKKvXH7SpzKMRD9/Ae+htr2m8aa3bYAd4Z2Kfp+jwdmkWoGMADhhrr3XdgXEc+hQQfV5GjneQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPQyC+f6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPQyC+f6"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1888164a12.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786971746; x=1787576546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXT4SFBtQg22RyD5ruYR6gzf+jPT9w6tFja2gCIjnhw=;
        b=QPQyC+f6DHrYUrwzhe8FJMsG6tvNkmcPvNWHDA7IO+CWf2STwByVBmG4S4LMPkWfuu
         8Mm3pvnr9UpMGqQt3VhNcrYwDWXKWU11UBhHCEmNDEvdU1fmby3FQqN7nRZpsE9cwcq2
         EF+CrSK8Ib1G5SC14KeXTtU84w2D7uud9YxctLPysKh9FFBROm5iqEuuriad7GtzPn15
         g9ex2cY3lYnA9tGMcCZBBKO14uYJ0/o9MpVBV1EqSmGkOdPXRBMdTufdYKlaRoYUk9UW
         kDbDP4q3e/z+sn0mMbq5YsX64OBCOPqkGVRr7aLVuCRFhQusRhoIL2ey0kJ+b4uyU3Zn
         msKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971746; x=1787576546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXT4SFBtQg22RyD5ruYR6gzf+jPT9w6tFja2gCIjnhw=;
        b=aBuyzg2LKGI053xqWG5Z2S/5rhGCY6E+zzpBuXe8xpI5CWciVlArH4Hz992Dy++H9T
         9Rdta5XvaduKgJSJFyi0nxqY+8pbxxc6uyVZ7vF+ZL1tBLx9xz4zAdrfK7BFcL25AK6E
         zt7XNO5MqEAnYitilsSO+gNzYetTW4bYiieiTpBv6GIO0+mCJ3Krn8bDHtiNAM/GWKrd
         mwkLX/4vNEeB4W5cSADZ0S/QVa046r65rG3mn7aUvF31+FWMG8mYnGSjPFw1+VS6JAUM
         zOkBHr1H9Rr1VBGCfP6Gf9613M4q3hYZckNPPLo4CMo7wcX3cakjKKuLZkoM3RnN7OkN
         i4Eg==
X-Forwarded-Encrypted: i=1; AHgh+RqHj3i6SEmq1FoYsDFKbLcExmH+NwmoQEgiUvN9QbBaJYgoiwlJr6YGl/eu9ijGUagkxhCH3Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FL2cZwes+FnvL0svcW65tW6J/70agZ81+s9oXH16qQvcib8T
	cv1vKv99Mv6XTx+8+Iv25wfCctCG0dskePHkMqVvcCKRArCgpCEQhsEO
X-Gm-Gg: AR+sD10ZKoUuzFaDpRSGvarWx6c6oZx6DvXoU64KqtBWqdt6W6juvb+I8SH5PPdloEw
	/UCp+yfTaT1mRLDaZ5DemvpGG47Ez0RjevGX7jkuQNpl+TbohGO2quV9mEnZV95q3qS7ba4psXj
	E4rx/PJuGanmHzOhZvsxWLf8hQFkiS5wg//5EWEXz1kO0JevKk/E7ay4k3YDGWtf0q1LiUfZpbj
	UOi216Qr/oGZppPFMls4/4BENj9sCDSloyYJE+7LbNkl+vvGr2O5QMU8T8rPGmKby6RV1VFqPwr
	ugpv0H9lowgBvTFmdJg8nBAP84ZJSlF/dgbKyX4B/GaXAK+Cpy3hoxJFd6dzoLSsPr9xcs5Zx8L
	fM2qW/Kou1gDus56s6pHUxHDYiw460ReWgoRt06X5bpawtaw77WmkR7CKBO9QM71BYCNK+q9h6J
	DZ190dTB26tu85CnJHXL6mg/xD66VoEDYmufNasdGAaYI2uRwZwEs1u3y2zZuv68g3b+362DjFL
	PEw2g==
X-Received: by 2002:a05:6a20:4324:b0:3c4:3672:ba6 with SMTP id adf61e73a8af0-3cc71caa469mr27110343637.22.1786971745929;
        Mon, 17 Aug 2026 06:02:25 -0700 (PDT)
Received: from Default ([2409:40f4:103f:ca54:3a70:ebd6:25c9:29fd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c385ec7sm5752812eec.20.2026.08.17.06.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:02:25 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: christophe.jaillet@wanadoo.fr,
	felipe.balbi@linux.intel.com,
	jeffinphilip14@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Mon, 17 Aug 2026 18:32:08 +0530
Message-ID: <20260817130208.17219-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026081701-glitzy-hush-b284@gregkh>
References: <2026081701-glitzy-hush-b284@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 13:10:27 +0200, Greg KH wrote:
>But that is probably a bad idea, right?  Shouldn't we fix that error
>first?

Thanks for the review. Don't quite understand what I need to fix here
(respectfully), should we harden the buffhds null check to include 
ZERO_SIZE_PTRs too, something like this should suffice?:

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 640d3bcb7bf0..98643d53cc7a 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2747,11 +2747,11 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
 	struct fsg_buffhd *bh, *buffhds;
 	int i;
  
 	buffhds = kzalloc_objs(*buffhds, n);
-	if (!buffhds)
+	if (ZERO_OR_NULL_PTR(buffhds))
 		return -ENOMEM;
 
 	/* Data buffers cyclic list */

Thanks,
Jeffin.
