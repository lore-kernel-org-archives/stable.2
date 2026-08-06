Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03238551D
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003860; cv=none; b=G795M5vcE2JGyh93IvpT2U9p8KOZVdKVWnvf+gcqsux3Uxh+UMCHGTxUAMj90ghLyWt4OOv0RTXgLFE+x1YSs5XN/7r2GJ8qUhfZzdEZL5E48AnWsPd8gdksQkRIS77sQR53VOHX7Gni9nDvolADnb9SZmWm1RUSgTFIFzgmK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003860; c=relaxed/simple;
	bh=UEWrfd+G+mMHCVBb1QsuXAJr91HYpvwPtjefuiOlkfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfMbmY1fWqakFEXvpzN++M4jDZgK1Rlfha62TRIP2qBcFaAsKVbzFfcJZKMYvP0lK2m4ipkyrkOTt9aYOzfQBBdAMrbINy1kxEyK2tev93V2gkdbLj1HqwqS00eI4ZqIVy1BiBT+2DZkwZ6GzgCILiTotHr6ZBYB24zi/jdLAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c276bd3692so1399808e0c.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786003858; x=1786608658;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AE6czKCPLTFc2zmYX67374xheDWCcRNEs9CRylGTIYw=;
        b=AgGUFkTJLlYMwVDU6L4k1ItYcrqyvLL3mCtf3YPEBzYECE8GdDVVWdjFXvSvniPcaf
         dl9ozH62hM95s4gYJtLuq32yxSDtc5RinOU8hV2ew31a/TVcsMcY46y3GZ58ZMnK3BYL
         e4Wz7GeBS0XLFw9Rb5gSCoAMZfpOgseWJIUqPtKUz1EH+acdP0aH4S85wBz8CNNabkgi
         fiUheQMiJqsv0PCRQzTn39doL1uZJStuNvMYfoflQ8nUgg/XrfoxMsRoVr90q4jtcKsd
         5lON4NDITZU5KXGc300844cUQ5Z6xw0I2+1su7P6yp4hh+te3dNJfyhQGtXKj4m50gT6
         aWSw==
X-Forwarded-Encrypted: i=1; AHgh+RpWtR/6CQPZO+pAaA0GdSrVr0b5amwxv9rIw1uunidorVxIwt1bFJvsRKW4afl9asxOXh34RiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6MdTlRaSedcrXxu3J+hUyL5RnNA+HscDdzZWQnRea9rmA37rD
	3rE78XAdt4ypA15rTpVsk4lIpv9lkCnIaU3WCW6wSRbNMg/QxC9F+bFrYwdFYB8h
X-Gm-Gg: AR+sD12jcckRZNtSZC0UsBZz23avy7/57nV/Z7UQbDuC/1yj7HHE8/KP+iy3XPJ9EN5
	ZZP/O7MMzTqIY1nkT2KeQxFGHix+z1GHakLGWMFLAoAkjeghkjozV5DI/HmXj/mypi2TP6hWlZG
	abRdA31Q4Nsd8rAwwr3Q7vZW8fnypttFNTTgXTvJLIDErVYBGwmVIT5rUd7kgUcZ+X7geDekj11
	E0O/v2qxEhkHTMKMEdti/J1kVxuB2NZcvJckSsqORZTOydHS/OOrBERq3RHOB9m5HD+QYlADBjF
	7IPRlXjEAkN6+MrjyOweECWdiVw32IrgKT8PBxP09rcRyp3BQFL4KdH6O6p7JuNtYMUfkvyVSnS
	hmX/2XEJqbB5MULTk35e7OsV2jR0Gi+Fkv5rLoeHksYqxQbUf83lTc4He+w+Zcx0m3fi4lQDNci
	HIICFZJXqIaqa6edG5Gvira/Xv/byukGWTQmSbgDsk08Ww7P0BI1HOWgKoUaM6TJil0H4++g4Cn
	fHf5zhg4Jr7cXacNEFbZddOJuUw7PsEATlw
X-Received: by 2002:a05:6122:d8f:b0:5bf:8807:b154 with SMTP id 71dfb90a1353d-5c3d941f4aamr1924172e0c.13.1786003857534;
        Thu, 06 Aug 2026 01:10:57 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d08e230csm2827740e0c.13.2026.08.06.01.10.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:10:57 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9693bbb962eso1092953241.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:10:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrK6YKu6lybwtVkXuQT6h3ikwJQO9ifORLY2wNB8PrIpwoZ8yQ1i0WJ/T6OqkzTBjLndBirlnc=@vger.kernel.org
X-Received: by 2002:a05:6102:4b08:b0:631:37cb:1e64 with SMTP id
 ada2fe7eead31-760e6acee3emr4218561137.4.1786003856796; Thu, 06 Aug 2026
 01:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-nh-of-alias-overlay-v6-0-74f21d440819@nexthop.ai> <20260805-nh-of-alias-overlay-v6-1-74f21d440819@nexthop.ai>
In-Reply-To: <20260805-nh-of-alias-overlay-v6-1-74f21d440819@nexthop.ai>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Aug 2026 10:10:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkF6TCcxpPQnhFT9697eKA_jGRDSOATst0GGVajnzxQw@mail.gmail.com>
X-Gm-Features: AUfX_my-HwUHD_sy425kXlXTkgUD0T4wDRnCNc1IBpqcByHHMIQEcGCMYh_XIkA
Message-ID: <CAMuHMdVkF6TCcxpPQnhFT9697eKA_jGRDSOATst0GGVajnzxQw@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] of: fix out-of-bounds read in of_alias_scan()
 stem parser
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Aug 2026 at 22:31, Abdurrahman Hussain <abdurrahman@nexthop.ai> wrote:
> The stem parser tests isdigit(*(end - 1)) before checking end > start
> and so reads one byte before the property name when the name is empty
> or all digits. Check the bound first.
>
> Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5 [Claude Code]
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
