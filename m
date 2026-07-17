Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6223D9DD4
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272050; cv=none; b=BOdU5VxRFwWP0rrXU/aCz1Z+cCu+k7GLMOkqCZWa9+HIjul2C4agMtpSuXVSnCEBY1NcdBiXygf+xkKL4t165xC0qfdksiI9um2jhl2Q5+pONzVBwTeUWPsMotNdNUIi6BKQ+PwlxFqXuMPRmiD+APEuJcqJO9RNNCpRVT5gCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272050; c=relaxed/simple;
	bh=TWJULxJCKYD8lAG9/bBgGAdQ290Riy+Guowxce5yRtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAEoQBQj4nvugaI7/HMmxqSwhrv+CEF5FccK5ev0XSq4EJLdo7n2fxH1nRLvGurTIuyIokMWCbv2PuNdCmTfk73uuyzprByqkpRj7WlbpkouUIhMkjS85ZG04DyNpYgi1vrbcxSHHCRpEr1IkV9EdVFkKm2ML9F5pruJ5Jl8FqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L8KGPrUW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L8KGPrUW"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso11080587a12.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784272047; x=1784876847; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkmhPcMQizpSJ0cxQqSXnDgGsG0fYJSSu1lv1n0/Fu0=;
        b=L8KGPrUWcbxYx0OHKMP/Guph4WWcxmOe5Vd2cfWelOLqxQVpoU5wzs9hUjKeswSkOJ
         qsb53uKf1zmiWwCatfTyTPlyqxEixeERI1umTGyUospMzuWIfuRjP/uLizwKT/fE6QT1
         F1fyy5Bde66JhzurnZv9DmYeAHrwHV7U5EbiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784272047; x=1784876847;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vkmhPcMQizpSJ0cxQqSXnDgGsG0fYJSSu1lv1n0/Fu0=;
        b=a/8DGwNCnD/JJPPh6QoTxk/Ghz7RCkva44hXND8tnIoNcsgFA2ZbUjlLi2FvT4Sv96
         pMaCR6iUGM/I+xPG5NiowB5DRU99zh5mcHH9ddKqQANEqPMtmraoJEy500iKN4FITax/
         X6vdLMNrHUK0UeHO/n1z+t1uC4fvqdbFhwaHFGSX/GuuZ7tvxmZ+pTKJCC8XNrN5zLy5
         GWoYNZqG6Kh/J39Nrq92n+xCF9h9AG79q4Ykf++7n8AZSHClsNFf6yigGs4UwL1QYLVt
         pC7yiBqY5PJfxZAfAtEYhBYyP0C0FWtQEQF+Qvv5JQ64E5m4JSUFTVlqa8C22h4f3dQf
         Iw5A==
X-Gm-Message-State: AOJu0YxaKgF6EU/ebaxZwrapwSR1AHU7vgk1/zI1QNxkeuKVMZLHuRs5
	dlrJVLuqMUsfA+yStXaQaRi1az1kt4sDd28A9SAXTYX3aNl6kI0huzTtGeG031HlOqaUNQqDtb6
	OF+664A==
X-Gm-Gg: AfdE7cnFko3j1qATCbp7whr3QihLwZmH3HKbHbkrCq0WnndLTnX7qGuM5WXS3mwIlzQ
	ZEBD13NhfoYl0yU8K5tkuP+mQxtF19Vh78Da3vPubpw85hb3hHGxK8Ocd11sK8qc/ZRE8+ELrD6
	0snIUikdya2KsX8HgcGjZAcocb18g/9BHEN/M7MeUJiPDsXtqPGKnZ3dWO/9VQFH09WpJ0D8xhF
	IRSkKJdrJkzq4asEnSjS/zcHHqNw3DVnCMn993E48eZQcIGeZpYuOjtO9BmlEBM2UXqsFojt1M5
	JizKZ1/UOaQhV7WIcxocoJZvuMS/EhVBdV2f0WCoHXMsQBfL18vePnF8clDf8w98ZeTawAX2NUt
	AcrgMCsnU/0sVo1twFumaZnPu8IUWddq9cDl4BB/LZyJfeAa1LfgA4gooJDsdWgnAKhHrTLZrId
	kewvtzE7YJJzkQfo9XKWekJYpJBFlEUI50OUyRWkFo03G8OGG5EQ==
X-Received: by 2002:a05:6402:44d3:b0:698:5f89:9a51 with SMTP id 4fb4d7f45d1cf-69e652578e0mr298009a12.5.1784272047329;
        Fri, 17 Jul 2026 00:07:27 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbbf4dsm212306a12.16.2026.07.17.00.07.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 00:07:26 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15d111ca99so747261566b.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:07:25 -0700 (PDT)
X-Received: by 2002:a17:907:72c6:b0:c16:36ef:d437 with SMTP id
 a640c23a62f3a-c16b477cad2mr54827966b.34.1784272044756; Fri, 17 Jul 2026
 00:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+2LXtmekL+oc8e48uUXL_2SXvfCc_v7MrHJ6JDh9usRHu0sQ@mail.gmail.com>
 <CANiDSCukMqtarMGb3F0Nf3TfTB7TxHDeWu776StV+0q5q1VSVQ@mail.gmail.com>
 <CAL+2LXvV66O_qvbrHeFyHGjreyart277PgfKVK7jKfJ-MXihbw@mail.gmail.com>
 <CANiDSCttWrSLoftLWPtx7XxYaQ7PRV2+Y0tvir2qaE77PMG1-w@mail.gmail.com> <2026071726-gopher-onshore-61ca@gregkh>
In-Reply-To: <2026071726-gopher-onshore-61ca@gregkh>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 17 Jul 2026 09:07:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCs9T2iDaptLnv4g1ZxNyRQqTzNCD=Ay2uRQoPeSaGv+GQ@mail.gmail.com>
X-Gm-Features: AUfX_mxXQFSgnkHKC3yX-O-fBrQDPXsqK6uhxbq7baRDiPyPihBRrXf4plhXf68
Message-ID: <CANiDSCs9T2iDaptLnv4g1ZxNyRQqTzNCD=Ay2uRQoPeSaGv+GQ@mail.gmail.com>
Subject: Re: uvcvideo: deadlock when async control drops the last PM reference
 from the status-event path
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-media@vger.kernel.org, 
	laurent.pinchart@ideasonboard.com, hansg@kernel.org, mchehab@kernel.org, 
	Jay Chooi <jay@robocurve.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg

No worries, thanks for the update.

Is there a public page where we can see the status of patches
(queued/rejected) so we do not have to bother you?

Thanks!

On Fri, 17 Jul 2026 at 09:05, Greg KH <greg@kroah.com> wrote:
>
> On Fri, Jul 17, 2026 at 08:54:06AM +0200, Ricardo Ribalda wrote:
> > Dear stable
> >
> > Could you help landing  6d27f92c54ce28cfbd2a8a479a96d6f4a781b7d2 in
> > the stable branches?
>
> It's in the queue, still about 500 patches deep to get through.  That's
> the "joy" of getting bug fixes into -rc1, and not earlier releases, they
> get delayed due to everyone doing the same thing :(
>
> thanks,
>
> greg k-h



-- 
Ricardo Ribalda
