Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179294248AE
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169801; cv=pass; b=LvC668FPYuA5rCcXu53MtbIl/sRkDkE4nhNh9AR2Xr2k4fqav3iRHwWXBobJIqL6AZODYAtKxK4lxNMagjbLPQHBqR1rzoIS8Vk+cEWQYqVt/EwKGdo9eJ9GDh+DV2OE2ZgeWMaFZ2pBAJcBSA/ZmjGXG6Ot2CexpY6hIsR9axM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169801; c=relaxed/simple;
	bh=4fw+Tj0+DQysQ6LoLPz6sEIQDfLSYGRYcdm5yHyz104=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRSMxX5N2t+5LLrzRxgD5b1dH3WQTI4OE5qi/N2iCAupyozIIe4AWaLhwI/kdcaytICzB6xAZaKcIyk+ZqnhPs4OKrvmrn9w+/lZ0Zhx3a0t+sHdsGJSj1xZI24FwH1xSaaAnPsId4G3jh8MHWCcJRd83/vEMnxtkbBDEaAEuI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWGd5pgr; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWGd5pgr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15d47266baso356105566b.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169797; cv=none;
        d=google.com; s=arc-20260327;
        b=FLP3R3SXlP/8Eg8jm2HT4FCrozxnPUp0MvCVW+g+1BO8OWeGeBzUlhMMEma+LNHwBB
         VZUBG+7gLIICIXIvGbrIun5o7CuEMobI/o2Z0bfHW49ZpNBuE7GYvlegVOQpb9xka/hn
         CEixM4jHRn5RijwxBkooG6De+KmJ5kzwPZ1gwhVvFGac1k0JgUo4vxmYnvZ/DtHU+N9i
         czdieLLgjQ1Hi04pGcoOqhKawN7F7pWut192bHW65Fa0jdCKO4QSdL7RmvZuLEqmMagf
         u3GATPEcMCrTjPJPFS+2Z8nLertRhaU6jUUIR9gPXgKmji09EOtzGJ46zU6K87CzVQVm
         CN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yssewUfVkwN4cFK4Z6j0f4XwofFyqvtnyN84dqAF65I=;
        fh=6PTGWGaz/uYKb2IEA/51hLy5S0Eu0lzL8WziP82hxmY=;
        b=M2v6mroc0AmBq6I3/gnHky0oNeglocgJtNfoNsZ6quuehtcg5gD1/K2gb7rMOBVKd/
         oPQ+XoJBAbWFum+DyIUVpj1PITksCwSJ6TQe78RcBSHhJMvxbdz+y3PxAw5/jh7pXYTZ
         WH+JEv0872fBJShZ7BsRJYhyC6mFh8pjc5UrqhRuVwLKNVbchJFr//zW2ixvl3XsaCr7
         zpWIMs4yPy0UIniVDfTPiv8L6Umn38h+jIy2CZzEE3ME0hbIku0eGYWn84RESKOJjyRo
         4LwRYeKATTGgYmWedfT8u3VT4u6xrwX+TyqXx2eYf/VXxfgN9sIVbYXRe8Ap6K1rl+LE
         mtUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169797; x=1785774597; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yssewUfVkwN4cFK4Z6j0f4XwofFyqvtnyN84dqAF65I=;
        b=gWGd5pgrF+i8kAH/mOp2E+LAfYJzJS578qtFnTqQh8cz5w8FXc/doegNcSFrB3DwQV
         xZHAJjgkJCy+zyXK4RKSkv9y/YuMu6WyeGfxeHT+rxyO8rUHV4/sO38PyKjiL6O+XBfy
         Qpai5QA0QJnUm2SqZpsvtwCdXFM5WP0fVvb3X+hOp8WSG6w80hCzv6eUyqjLeWW0VXu7
         ZYvpwOP55/qYoup1MWf/qsGFJOI+3FMuyiL18xJsieC01zv6Q18Uo6tZPKnT9aNCowTd
         qj2HlvWlNhPVWPov7L65H/Aqbqr0F3HWZ951EU/BRenkXNzU7Z/htfSv/WGmPHmJZdbx
         Zjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169797; x=1785774597;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yssewUfVkwN4cFK4Z6j0f4XwofFyqvtnyN84dqAF65I=;
        b=Rq3FNKVv9xGuk5DqVwDq7GJp1GhdjPsF7tCYLg5U2HBgvy3K60mjF/3A9U/qHUzkLh
         jtHkzjcY4YBYd5mx7G8XcxGTEmzK0erp7LIPp6NjaN+r11HDxsD9MbacvbcTIq65ZZet
         eZ8We1DakdZqYSBvJHxzGPjmEqDjyVSJKSSHJGGf3ixPbr9qaN9MlYaQkHMLfbAkwmYH
         P7Ax5luIgq5zimB+mINYUN1eZKYozYYdMeCN+/pRcQKoWxXjelxNVxi8fAs6BJdIDCWD
         4VGP95T6ZzNW3iyCkMduYx0ABrEZ3Bxv9rXhucbbOZ2K77wfZENJWYgMqadYs0cuAPi1
         EnQA==
X-Forwarded-Encrypted: i=1; AHgh+RqiQB1jAHD5aaeKMaSM8X0NF0p0PNMOPImNKN+c0P5AwkajqjLf1kbMnTzMfrfeJqxsmKuZ8c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRA0KnVaFNSLrI5+DdhWlaWgW9b8KCzkpqAA7edoVoOjV6vDE
	fb3pJQ0N4Noe33Kg/YEcNaF+YFvh6aSuWW9z/g0wzxuftx2S/6Pmf0iYhGFwYF2yJs+RbmVTtBc
	FIs/hxljf+qaiUfNVwzLe8Q6Hzw1FVmg=
X-Gm-Gg: AR+sD12MeZDJIpIn14QxV2lVlTFKCF0I+IbLSsmtON2k8I/3wO0pQ8Ii4ygNXq+VyQ8
	ftGzNfJEQZ8W7on9HIl1xW7Pkhte6zL/LXi2LXVqV/cjsAekmdfP6Fu0Cp9YYKF/miLa07Q5+Gg
	s2YxomTUGddpYPUt2M3eRQXSQCRQkZk6ECvAYQ2J5/LAZ1bnxzIr2bTFzfblOQOm3Ox9FR+v9t3
	56NNYdYNp4X/N6DOjpap2wILaHrQMrv0edZAGRb6QQ5NaCvrkYmSS1Rr7SQ7mR070G1pWM7pKT4
	XehxEQ6nl4PgRghYVbuwkRwM4ozHQgj7p/P7P9+9dX5bZ2o=
X-Received: by 2002:a17:906:7315:b0:c16:589d:c969 with SMTP id
 a640c23a62f3a-c1f1f0391camr387687866b.43.1785169797067; Mon, 27 Jul 2026
 09:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
 <20260717195336.98500-2-nikhilsolanke5@gmail.com> <20260726182946.79a4ef98.michal.pecio@gmail.com>
 <CAFgddh+1Bk=CFkKYNzB=L++UejkhCEcTHp4A2JL2v+P6uBuF2w@mail.gmail.com> <a0db0e6d-ba94-4577-ac11-6f2d26055427@rowland.harvard.edu>
In-Reply-To: <a0db0e6d-ba94-4577-ac11-6f2d26055427@rowland.harvard.edu>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Mon, 27 Jul 2026 21:59:42 +0530
X-Gm-Features: AUfX_mzffcfuwQcRNau6f9N-lR3BG3pBZBzfB8I2zKVV0zqs6e1HssoZ4dKzImA
Message-ID: <CAFgddhKMGMw1rv8EOHyW9ZNMGPW8U5yGCuLYBgef9a+FcMwX_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] usbcore: Add quirk for 255-bytes initial config read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Michal Pecio <michal.pecio@gmail.com>, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 at 21:43, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Jul 27, 2026 at 08:55:27PM +0530, Nikhil Solanke wrote:
> > For the remaining comment and log message wording, I'd prefer to keep
> > the current version for now unless there's a strong objection. The
> > patch has already gone through several review rounds and I'd like to
> > avoid extending the review cycle further over comment phrasing,
> > especially since the implementation itself now seems to be in good
> > shape.
>
> I strongly agree with Michal; the comments are overly long and contain
> information that the reader doesn't need to know.  You don't have to use
> the exact wording in his suggestions, but something like it would be a
> big improvement.
>
> Alan Stern

Alright I'll do those changes too then.

Thanks,
Nikhil Solanke
