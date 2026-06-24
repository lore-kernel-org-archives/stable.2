Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4B3ADB92
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289237; cv=none; b=kAnzo1Y/rm07tqfoMxS6Y5rf7PGUDb+6M8T7rVjwUO7L/9BWDrsTBrPGSWOfrG1IvQp7HnvcunID6a6VYZSjIq02KwIyl0kvaOpbH2VxNnf4U3FQjdjj75YK3YCVYoFchBehXnhxJQda/SWqIsaEzkrjqxWOLZE3JlggwEK9guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289237; c=relaxed/simple;
	bh=3v4khr7bduoUq4FUqynKvbWWJbzkRQYujPd07q95ffA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFH1hOmbCuTNbsN/JpIaJ99MdxHJe+SaYmqOLrk4DMDBseJaemnMh5mwlBUwOKjh3TutVDxL8f4jFmzFT8OVtuuVPOyFE8bWIdREBzAah5+fcGVrhxgfgR6FTWwIji7xQsgfdIzPgvxCB7hA0XNuBtwZuZf9O+7dhvFKswEK24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59f8a140a51so556036e0c.3
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289233; x=1782894033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++Q4kIE+3+t7oNuDlCHsgzEioStrRCXuY2iO5kkUprQ=;
        b=adT9YwRG98iz/jawakIt2dfCtvxKoTQU4ulNm9jNBktJkRdM7BdJFkEjG+UWeCuCg8
         IiY4ryc8HtE5Sx80sEI1TXNa70cYd6trOV4sah4F51+CqDBV9ofa5jYhZM0YdPY2DLXC
         dUuTaApe2jbjoxUvzv96ts48YG/Mk93AqJc+4Igog2GRqF788ltrjn85Sm5kQdlxhSDu
         2LK7WIbbRnc0szHmQDN240DXwLrmC2vylsV4hmEqJTIT7azZZwerV2t3FCBDZZBvB7kY
         j2USV8GVGxZC0L8+3lhuK5F7f0+rlgnx1wcc1N50BLfeGMPFxJxsBklwDRz+whY6yzN5
         IQgg==
X-Forwarded-Encrypted: i=1; AFNElJ8DWlNRPjSM0bTA4BvyxOHDSz1ixxpK3YXlDb16j9io3QnWYEffp8xZKCjyBGW2yR0wvzot7RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYLalqU9thKIbpbpJmRL9fzMH4ScCDOjc2yluKko6Hmqxxje+
	S7WCJKbCflcNYPSHc7V+3Ais+PovG9MiQDiAnbu/xOxazvNl/04bqPMY6R6NmtDD
X-Gm-Gg: AfdE7cllcLUgXyav2gj8Y/E3E17QthZr3iH9v1HayJcsmFqcAn5WdSqRs3r6o0UesAP
	M2hrMuRDrXYle8vRi7qVo2Il6Kc1moX7CpknMsqWC6N+QwvEcbDM6xmgdXnljFc9CU59AYlX/n6
	v1u8gQ8f0a5BsgdnMQDJ2AZncP3UFlAnxNMhVykfTpG0zzbf6tSjJ2Uv8umv5Z+YiDuNh4QG9Lj
	O8rfFGEd8GZSzMTsgOInWKSjLo8AuOGiZtts7uRD9pa7JHFft4hrCl2LUGrEpRX9rXr9ymDySuJ
	f7fuHl2fEVkcRMtZ1pLTK6vMR/zp2Lbcqz1J7v1Tgo6Y9LyE682Cvyts9skQAV4RydgHmmKJXm3
	WCN0ijq81hW3Y+L1U7coi6xnbjgMy0X55XjRcmM5hvNjrE7oVKuagj32Lb22EOTBA82oYiHyHdF
	5Er+G/bg8w017P/9C0x3edCB7ECbfNMU0vvK38puV5i8QcsqbB8A==
X-Received: by 2002:a05:6122:e26a:b0:575:ad04:4b90 with SMTP id 71dfb90a1353d-5bc3ed94bdamr946149e0c.7.1782289232665;
        Wed, 24 Jun 2026 01:20:32 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfb5381fcsm10220043e0c.0.2026.06.24.01.20.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:20:29 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-966d7738c3bso456223241.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:20:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9gmwbelycwxcVkV28wmDh3bvCpxYdV/RUCezCfHXP6XPsVPkFqXQU7aoJGeXWfW/LCAPyOC2E=@vger.kernel.org
X-Received: by 2002:a05:6102:5248:b0:729:c8f0:76bb with SMTP id
 ada2fe7eead31-73115109dcfmr909821137.16.1782289229026; Wed, 24 Jun 2026
 01:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623042800.1848398-1-haoxiang_li2024@163.com>
In-Reply-To: <20260623042800.1848398-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:20:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyhwj_YZF00ssYt94n9ceHD2s7S+r0kKd9QsBYAc67gA@mail.gmail.com>
X-Gm-Features: AVVi8CeleHUq0cBQ5Q8shQdH2lo-wZ1vo66vFQjtlFhS9beCidh33XrsUDgUQmM
Message-ID: <CAMuHMdUyhwj_YZF00ssYt94n9ceHD2s7S+r0kKd9QsBYAc67gA@mail.gmail.com>
Subject: Re: [PATCH] sh: kfr2r09: Fix USB gadget I2C adapter reference leak
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	lethal@linux-sh.org, damm@igel.co.jp, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Haoxiang,

On Tue, 23 Jun 2026 at 11:03, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> kfr2r09_usb0_gadget_i2c_setup() gets I2C adapter 0 with
> i2c_get_adapter(), but returns without dropping the reference.
> Release the adapter with i2c_put_adapter() before returning
> from all paths after i2c_get_adapter() succeeds.
>
> Fixes: 5a1c4cb5bc22 ("sh: add r8a66597 usb0 gadget to the kfr2r09 board")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Thanks for your patch!

Before posting (or better: writing) a patch, please check if it has been
posted before:
"[PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks"
https://lore.kernel.org/20260508120601.426115-1-johan@kernel.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
