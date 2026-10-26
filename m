Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793008284;
	b=P4jrsMysJGl/p3/41v4Uau0gbhE/K/XJjVuYbzWay75mZmzSuA8ThzyNFYJxPgmaLuy7
	 Lt//5uEdRDm21/Z1ogTykQjo0d2J4CaxbC8nQBgE1ZYQHuFwCNMCe5upDmGmw/6JxVsD/
	 WwfoWL8kZfQVA80XYJuNr1jbcyVsjziDxwhpG+jKDp5TqedBaQpTF+VK89O3tJRDCl1yu
	 /ZtJTTwgdM1FLpNrde0aauQ2PXNY3WU9+9RgFd2ojqz6skPGmqqXk01dzatc0q1updnkr
	 3E3znnnbKvM03bKobNtVaNm+1sZr26O26QM/fcjUfZNaO+phDintlyiwk/1l8DgQ60w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=sMhuh3ssEtrVnXk6HO0TcK2T8EckvQJHYCkZcNxPLsk=;
	b=VnnCR39xPS/RzYQBYHUHKae+jRuiFqsnDkFutJhdB/U7BH/oIPr9HzvdTBdyMp57MiCF
	 yqdRfAzyyS1/hsB9Az3yOdhdYd8Kd2R+qYoOLNvJt1csssnCPujyz9UyetTokZ2cbb6to
	 mmnE3CiA5O/sEGbS3Vnq+wBc5pmbybZtmfJN6YyFJ7/Z+gje+it3KHp25rQe8SwxdGb+6
	 gAkOtkzuP3D42U3sYB+UpFcEKkDYRRxOP4DxqlbO89iJsdOB/6knuz5JQTjTVTn+vob9X
	 0rR5LXl5e5yjGZXYU0ZTLbk/Bwl2j3/4kdqkhzPi6VMfmYBYj3GZRmglwGhTGqTfqxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oZ9MzXUD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AEF606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66AEF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oZ9MzXUD
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso405098566b.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793008283; cv=none;
        d=google.com; s=arc-20260327;
        b=TEmooos9qQVoIFEcyPKcfin05R7Ly/Nfx6u1aSrfqW9qbUkHyAwY65+UDdDrWZTHTX
         vlR4yPBeBtPGvnTkXvQyjvKaGhs6r9Clsa8C3OHHnv36ux6aHZ9X9qPy2Ws67w23vRss
         iYLzhEAVv1x2cWRlM+vQoJo5WWnpbQSN8FG9OyUr0juGWbZAzssI4ukpYykTroZxN8kg
         5gjwbjemMhiaIz8I8bQXxOjuHEMZhEhTHs81H4FhI9RYz9PEy84puJ6XVpL7pUcLEly4
         0RcATa/JdFOnZznow+BA37QwfVbGT/+cB1AqyOjJX/y3VOZyJ5kVNzitAQdhn3FNYe6D
         2h5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sMhuh3ssEtrVnXk6HO0TcK2T8EckvQJHYCkZcNxPLsk=;
        fh=tXXTOo56Blot2HaexuZSEhsrfktjd1dYzWM9opzSp0Q=;
        b=JJKBeaNEyh+aKkfdJ6YDKCtNZ7viQDj9d3FRUT+Yv1riHqTnDZ0NrWefpf8cNYCm3+
         AiMTKKJ/rbs5paOdDDzomNexVbbZYaENLwU3T2kOn9nBOw6ExqMN0SaFf89wjZTIIdWs
         Y7lMEvXGIamzYA35n9YIRKrmX+OCmaGKMKfInYhUFnTWQmOmr6Fx9KMmgZs/PWBrgtwY
         HOw78Hbd8bQq+q1cihNh5R+2H8VPhTb3yTHM4jOdkb3Aqf8UD+f9DC1GUOt2DkPGReeV
         IiGJVzqjX2K2TvhKUD5a9npVkHeqQL+21WhSHEiDZNOGvOA//S6a32jjs1Z7qI8ceDi4
         GxQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793008283; x=1793613083; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMhuh3ssEtrVnXk6HO0TcK2T8EckvQJHYCkZcNxPLsk=;
        b=oZ9MzXUDf7HfWK3jc2g9/t00ivshAOuwVYANWDpUYGdo1OpHWHbyj8VQDUW748ith/
         TbKKfhuc8OEJLvw1X4j3qEyZoe+dCtVBpjpx/louzQKmT0IKS+5smIemmNeuVaeuYfsy
         z/gH4SKAAevn6l6rHk1BQFxKZngQH+o+hyg0KAlQ9ejNjTzf7XWCDs9sCUs03/0Rx3d3
         BBRR2z6VTzSVE1LEgxI2XeNAF1vYWotEgmLS0hWeLmGLJm77j7rS/UlLZtbVZ0o1iYT0
         6myzdyKPCr+1a56PNDOyxZDpJ+3qYKigBadUFEQCjO+2E0zekT8nf4nif3BnuZm7ZVuv
         5lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008283; x=1793613083;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sMhuh3ssEtrVnXk6HO0TcK2T8EckvQJHYCkZcNxPLsk=;
        b=r1GShSU7s+Webu6LAb9jZEReXjUf7QIfl9oraVPrqQE/etREiejye09JyiiH/wVgIl
         yYGdcrRN0ABqzxtTRgZVTZvoJoRqm/1JDh2hsNZsj+e5yK8pS5Pa6Pz6KbW6mmNUc3gg
         HdzgXhOZOjVOfazd7QKyTfT5I39xJdzOXO/jq5+IJdkAgun/DypoJE2lYGkh4pFECRUM
         JmGDs5dfHeY0eApWDo8k8ljm2r7pbsoNXfx+pWFADysYe0GdqYqOksAu0XsU6otmP1lU
         D/SQhyjh8KyQQxhYj6JDo47sCW/VDVCpu2iKk4Yo7nUBqKs1UwNB0bmIZjxTS1TM3E+2
         hWjQ==
X-Gm-Message-State: AFq9FYKP2zD7lSeWDVs6x2qqaEImmEZVnbehd3yJID/PHWDlGYwCXe7j
	UC1KPsatSorC44NXJqMVBgdwsTBzNfLwXhv+KdGQzLJhXo/bwBqQlqcuM/u/5YxQUkjXSef59W+
	5rqR4hSrzLI5gpeUtg1uQqy+lsnghY50M0S+DU9lo2A==
X-Gm-Gg: AYBFou0QHeYirM0uAgDzplWnJr+F6Rc949m8yDOuEuy7V3IYm80mmG4deOHqcorjwyQ
	8CS8m+qgijJc2aULy2d8jXZaEOTMU++BI9woHUAjcrg3UbAKWqVcjvH4dK3uMUxBKSqy/SADV5H
	jtwsoEjcFXPeTop8n1jBa6sV02F3VQBwV9VN7bfL52l3z7CDFuPEYGHlm1j18t0eOuLKnz7J1zM
	6msITLj68xafrUS35ZRuz9Ct2I5YcuAdF0SLDq2inD1tdXFACigT54ClNEfbCJShZAF5C4odRCk
	O5BhOcvIa7PcEyygxh4BIOGEaRb/UHX5zoIVlxHO4IB/6zIdT3efc9l4XzrLSi3jWnyN/sxLFgf
	bwRaZ3WqLP14/0rD73nVJimA9jMj1ghnO1PCgL9dNptD7PuBHXqUdXgqTgxs5BsJfwE/psUDMxc
	gLALC57trUmDImQw==
X-Received: by 2002:a17:907:1609:b0:c46:50c6:f737 with SMTP id
 a640c23a62f3a-c46bde6b3f9mr793711866b.31.1793008282769; Mon, 26 Oct 2026
 02:51:22 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021131517.GN2823843@noisy.programming.kicks-ass.net> <2026-10-23-1-daily-reply-0017-sched-eevdf-single-runqueue-7-2-drop@kernel.org>
In-Reply-To: <2026-10-23-1-daily-reply-0017-sched-eevdf-single-runqueue-7-2-drop@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 26 Oct 2026 10:51:11 +0100
X-Gm-Features: AclHuK9JAEfoIsJIaBqryqOWYsEiOeAZRJ2vkT2i8t2HWPa7K-0uHDOjUT_OfTY
Message-ID: <CAKfTPtAfLwN0Q9MVq_KOPP0ozaN_+tG132qsTbHLAeO6+QOLxA@mail.gmail.com>
Subject: Re: Patch "sched/eevdf: Move to a single runqueue" has been added to
 the 7.2-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

On Fri, 23 Oct 2026 at 22:03, Sasha Levin <sashal@kernel.org> wrote:
>
> > Ufff, why are we backporting this?
>
> It was only pulled in as a dependency of "sched/fair: Avoid overflow in
> place_entity()". The whole chain is dropped from the 7.2 queue now.
>
> Peter, Vincent: do you want a context-adapted version of the overflow fix
> on 7.2 (h_load.weight becomes load.weight), or should 7.2 just go without
> it?

I'm going to prepare a backport of "sched/fair: Avoid overflow in
place_entity()" for v7.2

Vincent

>
> --
> Thanks,
> Sasha
