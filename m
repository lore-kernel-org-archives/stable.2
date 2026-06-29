Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600CF38C427
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711070; cv=pass; b=qvgaPkoCL+rvsL7KddaOa16EBvWPPkWEOgtktcZrKhcrHaxvIwNkftqGmYX2y/9W8B6ZGQ9UZsDP6oG34SH+FDGgBF/JGUYGqhOc+J/CyzRz8mvqL/H4WvJeVUoNAgln0+uXjMWyV9l5scs7yOlOCZ3VTZQb7ecCawl/gRVtMHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711070; c=relaxed/simple;
	bh=epmWe8s3QLJXcy4rA2U5Y/B/KOdqRodzVHArrGYs0W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a001cuHItHhuCU9yY5NHVNi3JzZBwShmOOLQjDjdFgAiBwmIif9LMZIp/nq/uGBJ3QHa9sT615YaxhkFEytHoVfgOx3IMHZgej6WKafXyaLnxqhgYqATK5B5YTocGSXRpECj+JqvK6RR0C7sq0djfbrxCDV5L5HLskvTkJ1+HIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV4j0iMx; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV4j0iMx"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1268d56234so55400466b.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 22:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782711062; cv=none;
        d=google.com; s=arc-20260327;
        b=EEIloPAEX02f7HEZt0mRK79YxfnzqXmpb7aROrWEbCpVtci4opaOWj+dHLwrQQZw5s
         pP7Il2/VBEduaszYRGSRU9Xx5i2I8/6nNoJSOHRNvYrB5wgIHRWCkhujDmYcQzBfW8/i
         o4gkBNjar5uPhI07isPKWLr4NmTI9aJxlv5qdCh7ndOW7s5sytmv9XItqpiyqUNfs3AZ
         sA0tNUNgVfz+O0jpZFDzgNwBz5ZKvaFJQazM03kmSzYD24vl9RIqaBa4QuNPKNPng6Bx
         bftltdxtXLt7rka3HnfXGfkjMLGia5DtyXU+hI8BPryO7Rm+WeWjAhGK2ANizZ73nH0x
         u+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=epmWe8s3QLJXcy4rA2U5Y/B/KOdqRodzVHArrGYs0W4=;
        fh=BX0YQrst5UTBSz++5Be5OEMkUabgT4rXBIm8ftzAGBU=;
        b=OCrN6nUqn/thwXkLAMBiEFmwRhMCfc7ZDkorhZnBXW0ZWwTQoYTem1Fe/wHwQnNrDj
         i89RaOHSBf8yVKBGuDyXHDkUSlpNFa+2M2NdA5mNMlGWGDP3M4H8EZL2DLQ7EV3BhfZr
         KtOolXoog3Y6ytKR0iX8N54Mc/RI5Hlqap9qe4ziuEIRv4x31/TD7itS/DHOxR5oTtLD
         cvjPqqCBd6PuPd7C9LpuDiaTdyCKWKukAeE3hV3yOtQfI6vIxjwd13LQ+pzLbTUw8ud2
         GJkHk0UxDl4zI/EXMSbo+ti5lnMSed6M4u5GQObAslND7IdihPGyjurN4xQSJLWduA1c
         W9pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782711062; x=1783315862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=epmWe8s3QLJXcy4rA2U5Y/B/KOdqRodzVHArrGYs0W4=;
        b=AV4j0iMxr+XjllNcw9Eu7cPbbJJRXgdZRub0lsu6FrFGGmGRRomZmdBv4ITGv20bbK
         ijAiIDEi0drAUIap7BTghHqkmP58Fvu6iVRH3nzKiup5rSoPwdZpbvxrOlEc5a3O0uOy
         0nwUaHB9GbI6cdw2ReM4r3WYhh4gY8bZl7AmAXIk6YTzBbDMfLmCl6fklSGkqaSMqkZu
         eliHS0scf2+h5x0y2jZujNZOX0yBLI8ekRw2Q6sObbclqM2zrXffjAUIGVEo4taiVRzM
         jfAZ330NqTAFuNCRZ/Rmopgfx+3P8T5VD8PpotMvU7YDUQkYknXK5rou7ipfD0Vcpuo9
         8Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782711062; x=1783315862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epmWe8s3QLJXcy4rA2U5Y/B/KOdqRodzVHArrGYs0W4=;
        b=JxHrbeKKEapdlQzCwn6ScqXxVWUn+AiO3PydtVwVMcOeLNTXNuAeKcAGGBgRxbtPVT
         9hm9NrRnJiBs+BlmaJ7NdtD2cTnAG/dN7GKpx7usQ5QxV1ElO0jlB89xx0O8ZbuoDRt4
         gpds3hKghOm1NhY+Rr6HhY5tIAzo++TKfpOUlDfXdYLMyC4F7Piz++2ZHuOqb8HhuEmm
         5u3BOF3KnCj/LknVu4DPhWbyIhO2Neretp7rORD0bqUHIRu3+Y89CU1OJai0Bh+R9rtb
         I7yOPkL96RKtxbFKiF05uZMcQfMlXT0qcRAeewuHgC5uPc1RbLE1X8KbHm4ia7bLiFPh
         4wag==
X-Forwarded-Encrypted: i=1; AHgh+RqZV1GxLJ7BX/dLC91H7Xb2HZXdhx7mKGP+cPoozSBLAX7S6tB6BpHSrJJStr+VZbQbuItF1OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlY8v3vksCv6vNVWA+rNfE6DEJrVpG4EEVHiMWGDWv2wuwA0ot
	vIhpmn9T/trO7Ug7Mr2jFfncPko8Qj9lbEEWvmwAMA0teJ8WkXnIc4F0O+UvXX0i5M0o3W6b+wl
	6NQgDpVY0dPX8sA48q60HVUqSPtCUl+zjOEJBlnk=
X-Gm-Gg: AfdE7cmazsm+YHxlPPJiMAKYZhdqFTcVkisKQ77n0A7swfqF9rRp4zQSSE7T0kCRxZS
	Y5qd9er9kpaROkMZiiFdMi6yaxvQLd1lH2Bc8lC5ZOWNZp3kHssLUDQvi99nf34ta1bMpUJiPj/
	qbrWPHljtk1bW33XzpZrfPNr2CAelMes1Bg26PIzs2oUA6Nec9jNZ48UN+yk+CNGO7N6mkWBbHD
	cI6QcrBitAvxAbq50iYXv51/yzyYKPO/428fwWzEU2TXQMKTK6J9WHBEYLrZtF3d+Mhv92NFFfH
	xbKhZck=
X-Received: by 2002:a17:906:c141:b0:c12:2aac:2b4b with SMTP id
 a640c23a62f3a-c12336c2698mr415388166b.44.1782711062080; Sun, 28 Jun 2026
 22:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com> <20260628231634.6752f74d.michal.pecio@gmail.com>
In-Reply-To: <20260628231634.6752f74d.michal.pecio@gmail.com>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Mon, 29 Jun 2026 11:00:44 +0530
X-Gm-Features: AVVi8Cetk7IhAA3m56dYLZoJwEj6Rfc_rSgjh_WDaPAAo5ultThdmtlYIIEH2Xw
Message-ID: <CAFgddh+AUNH9Ji-Qd=BKEDZWJrzPMWN20-g-htQDPSdSehZStQ@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, 
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> And here it's USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE, but in the commit
> message it was USB_QUIRK_CONFIG_SIZE.

Yes, I have fixed it already.

> Honestly, I would suggest a third option: something with "255" instead
> of "Windows", because not everybody knows how windows queries
> descriptors, but everybody knows what 255 is.

Well naming ain't my strong suit (if I name something, it will
definitely get called out). Do you have a specific name in mind? if
your concern lies more in people not knowing what Windows does, should
i just make it apparent in a comment where it is set?

> That's a lot of capital letters, USBCONFIG_WINDOWS_REQ_SIZE never
> appears outside this function and personally I would just spell it out
> as 255 here with appropriate comment.

I wanted to avoid the plausible "avoid magic numbers" criticism. If
everybody else is fine with bare 255, I will just do that then.


> > + bigbuffer = (unsigned char *) desc;
> > + desc = NULL;
>
> What happens in the next iteration of the loop?

Disaster to say the least. A memcpy in bigbuffer and memset(0,..) on
desc would be the correct approach here, wouldn't it?

On that note, I discovered that usb_get_descriptor just blindly trusts
the caller with the allocation of buf, it never checks if buf is null
or not. There is only a check for the size. and then there is a
memset(buf, 0, size). This results in a segfault if buf is NULL and
size > 0. Perhaps it's time for a new patch to fix this?

> I wonder if it wouldn't make sense to split announce_device() so that
> the first line is printed as soon as usb_new_device() starts, before
> enumeration is attempted and possibly fails.

Do you want something like announce_device_ids() where it would only
print out the first "New Usb device found..." line? and then
announce_device_strings()?

Perhaps even another macro announce_device that does both? But its
only used in one place, so I doubt it would be necessary.

> That would be a separate patch, of course.

If i have to make this change, should this be a completely separate
patch or is it fine to include it in this patchseries?

Thanks,
Nikhil Solanke
