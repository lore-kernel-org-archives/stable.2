Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8638C421
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288403; cv=pass; b=UXDZo0Z1kJ3Sy1eB7sExc2qEBZ1DJrg1D8/Oe4H7EtIkXVE1HZ+sKfV4Lt5GtsYRWeeZruQG6Rml84+M9w3VUIfi+Mzr/mmHGDnemtL80wBecMJHiU+s5rFmMpK/OEQ458MqtUlwhN9y70F9PsPr6QiVP2qq8ihKEcifkMcUqK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288403; c=relaxed/simple;
	bh=gZeNPuamGXtqBkLQzEmuZPlOeqKMujWLum9QRt/g1bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2PH+m/hYyl9jVtPYSL4caxn4NcUYqgR+L767ZP0DtSB+zYCi7Z36BGZoMHsST60eqyo/2wlGCY4E9tjnO+w2iQ9PayOdk8Dn5ZNXuHZjTj+nKIWvd7Vh8M4jA4z6BMEk7cSSPM3DcQJyfWXFUcEc9sOSdmp+XlHmmxc7Nn9HCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzYxjx+f; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzYxjx+f"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c08acccf4a4so85686666b.3
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782288400; cv=none;
        d=google.com; s=arc-20240605;
        b=SHMu9FFeeOdk04PKHOO58EidoKBDuUZ9XZQh1jy/edEbElWQiDWFgVaxnJ/RvVCbvh
         frJ7dRg4IdLRO1G0SXnEUCWS4Q2NJHgGKKu7REQhxymQATCsLf3D/kpJ1RtajfQ6Sl6l
         CNmIEXM60aWCLdRY0TrYFw1JodFhoMAyZh8iCJ7N/XXPgRN45y4gRlLn28IOzkCck4D3
         G+YPrQy1BbL8hWXdaNw0vmJkOXUEQ4ZVzWKx2mCmQ63cyfNqESJJQrTugrJjNW/H4sgb
         M8syCAlDHUbVcyCCdTunqxF7AiGgFbdlsR2UFOlL9rAhmFytut/KaX4x6y9t0eKPjma1
         V9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lM0sj/gFrnWNNsB/THsiD2+stmMptnCgeunijBGiJP0=;
        fh=Ck+gyWpaxXP8Vuhe1Wmm41xsvueVvJ9B/66o1MU8VLE=;
        b=Psci7ARVBjvXEROWVYyQqDZNCs6HubT8OboNZBz0qHJ1FxNnq2jG1Q4Isn23HRn8M5
         Bm2daFml9x3NFbh1gX256Wg3spM7zwrjCdNM+xjShJrmNx0J8oe3wCA7z++VPZZJuDnL
         WnqxfcQAaAocy8COQSzi0932eaqyWKkHoI8L4jiTQ/hObd79RRv1say/di6qQi0w7PqH
         kEk9Go/NAqiMk3ls5cEn4rVnspitqFeJ29IwVBt8c0FwV/rOvSDl3AcfzQWb42RqqTcQ
         XXUXAHE9eMd7Zy6b5HJtEmCzfuYzwtNlo88rBXTzBuFtul4CPzdg8vmh4I8fkHVjZS6x
         p9fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782288400; x=1782893200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lM0sj/gFrnWNNsB/THsiD2+stmMptnCgeunijBGiJP0=;
        b=IzYxjx+f4Z8/We9K/7J6kIBnc5HIvl0pZPGjt0PCA/kXigCxu12jPdOVWcGNxvdVyK
         le0cfMTSELGrd1aLyBTP6pYgGScgfLU04A+24F0B6pv/D9vnq+35RwZlBlccCGvXCZFr
         UE3SrjCjoEweZGjKoK2Bqp/fDjb+CjnkVMLXUSB4xv7JWSVpFuu7B0Fv66RGcr7QM0NK
         8Rb0U5IxYYWbeAuCsCtBpY+Q2riaUJdnYOkrIDAiOSgOKMkMkpRU8SaoWGhNLY0EqE7t
         EMAl5Z/D5GX0h9L0L+zHv1H1oFJ6izYxyrlPJlzaa/8GvgX/Vz1MciPYBKvHqYGKErCC
         yxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782288400; x=1782893200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM0sj/gFrnWNNsB/THsiD2+stmMptnCgeunijBGiJP0=;
        b=qKbfQEJslevucemzMW/8xREHBl1dGgyf2H1rcC3F/fckvMjR4Pw6/GbUoXB3cjwtq6
         5n0tErc9aXe6AgbQYWCKgCinIBDBjW6b+p859ZrAj8qd5/0cOXZ1P/uVA4jWHK+vemcp
         oQAPu+TxGCsRbMCz0+pMp2xTiESAjDFQwJdraBQTC/sdroYWaVUSJxz/JMtAW0KN4K7O
         MAPfie8cthexJwgkK6cGRqE1CV3I00fSa+Y4kv3dwVndpY8UhZtB50MLynR2Kxwn/li2
         9cHlY0vE+vFNUSHUjls11DR7wjahF+WSrc+hh8jcU9VyTeMiebS57ubBSXM9EX3NwWKd
         e5ew==
X-Forwarded-Encrypted: i=1; AFNElJ93/YMzm+3GWRBHOUhkFJJokvvNr7eULHwDqQyRD+tXoulnb3b97Du2gJmziyqMbD5JKv4fsS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJp2epZLnTA/WF/x4naIpIBLgrZyi2TLUaG01cN/KhUl7tvUoy
	8qBuHQjWoD6toooQjYiYbVbvm8HUItA/MZ+sKaGi0FdCvGG9tgSzz8PM6zojjrW2a5JfU4nnYAF
	vdNAXLrhw7A3wafeHpNr5h5vus8gWdVY=
X-Gm-Gg: AfdE7ckvwOe2ju4ry4gFEte9Imtx6gGQ852OkHA/iAvtK5qwdGUur/bxoHDdQzF0hYv
	oUeOedThRgpl7vIb/qclDOg8GTWVRm2HbjhuUWVW7ehFMLqxLzpFWTTpsKGVCtDOuZ6SUuIdwPj
	0KAcAK2m1ajBXy7tndpsioi2xC2RCHJEjMsiF9Bm8h1UznHWbHwdV41hDTq6xXPgXRwuLV4Oc1a
	4b7IBfa9YU+G1mtR2se5jjbouIZXilqnhbCYbLOwJwVUMpOgcKAb90A0wlzGaxR9MC26TkYkw==
X-Received: by 2002:a17:906:9f86:b0:bfa:f563:9294 with SMTP id
 a640c23a62f3a-c107e0dfebbmr347805666b.18.1782288400043; Wed, 24 Jun 2026
 01:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com> <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
In-Reply-To: <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Wed, 24 Jun 2026 13:36:28 +0530
X-Gm-Features: AVVi8Cdz6KHrxpF6FVDarjMSsiC-uOJ-UdMHqIhmrG7YgFP-x12nJ9Fo0j02HUE
Message-ID: <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com, stable@vger.kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Actually, the best approach here would be to put this single change into
> a separate patch that comes before the current one.  That removes issues
> of making more than one functional change in one patch and improves
> bisectability.

Before? Shouldn't it be after my changes? That would make it easier to
justify the changes. And just to be sure, you did mention it does
align with what the intention of USB_QUIRK_DELAY_INIT, but it does
change its behavior when the quirk is not set. Atleast from what I
understood from the documentation and an LLM's summary, the device
needs time to prepare the full configuration set. So, does delaying
before the first header read really work? I can't test this since I
don't have a device that requires the quirk to be set.

I personally think adding a condition to check if the quirk is set and
then delaying before sending the first request would be appropriate.
What are your opinions on this.

> The style used in this file is to indent continuation lines by 4 spaces,
> because some of the continued statements are extremely long.  If you
> want to align new continuation lines with an open paren, you can -- but
> you didn't even do that in the example above; you aligned it with the
> space following the first comma.

I will make my changes more consistent with the existing file, i.e.
continuation with 4 spaces.

Also is it fine if the string lines exceed 100 columns?

Also, is there a need to check for krealloc()'s return value? Since we
are only shrinking the buffer, there won't be any moves or completely
new blocks (at least as per my understanding). Do I still need to
check its return value for completeness' sake?
