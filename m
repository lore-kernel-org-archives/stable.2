Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A965012B4
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745359; cv=pass; b=ODItsQjUrq66NT/w/mfNRIkTSl/ZtSAREmOwTRopfChgabbvRGxNl5o5U81SZ7OaU88nu620y2a4FnQwU56YY5S25f+1VksTPLSbAKcbWa035RAKVF0g5gjwf3LrZIJh6Zuh2lEcb7UM6fOB/UKsFUsDLJQbZnVx7JH3Ezd3gaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745359; c=relaxed/simple;
	bh=8XqNRBXt/qlgUXB2hfT5CeqtG8EouGcWeggFZCzuyw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJzVb4GQJHp5hZO6+fPWhK7gGVAfguJcTnPDtRauEiy8hA/am3I/Kb/b5w3arqv2umoBNZlkL/HEiYCvxZk/wlxv4RXwAudv/aJ6rsVLrMBOdBs4jJf5YDcgpBB7cheUJOnUm3cObhwnmb88hGphhBa3DwXfBhxtX25wERiZ+3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGyfsTX7; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGyfsTX7"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66fb7ba702eso158694d50.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789745357; cv=none;
        d=google.com; s=arc-20260327;
        b=JsoBUtKHAac0jW71btBM5hnn5A0cmqRmsg5TQIasJXc+YCx7jD5uoCMyHo49k7XIzt
         Po1R2iLmFs0ciiKPbADSJu0GvhzrSCmB9zXlJW4uCytPpiJTmyD5J3QzdhPy/4QECHqS
         vYEmO0s9PntZ7KFeJTpBMLB6/eVdpkFHgJfrAqjkHwI/xWn5RFEyE5JP0kqwLD62JVB6
         /L74fLNeauqn396kUnGqCSRoVQWQfSc43XWnFhYoOlO1XYByxYexkiFEnl9Na9xEgE1h
         ZtyxBHu985rE9OOILnfFjAPQyf39IKYLg0BNkPAfqu8DMqjFMx60qtPAP+XHj2yGJI7p
         6DeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8XqNRBXt/qlgUXB2hfT5CeqtG8EouGcWeggFZCzuyw8=;
        fh=QBEfzDNHgGKIQL37WpGjVhS3XAYMzlSESZYWoJJwEWM=;
        b=i0coMS8SWMMDl2eTD35wPRpTQaXBKUnWCb/vLIANKJz00hi8gkG7HJVDDQew/VFx36
         IRHpIaQ9+CDX6jBK2rKnUwF4jIBY+ZLdyhauVBmCJxF3VyAyxn1kBWL06bwzWWYHygs0
         4WhmDqwQIKixopIzD7EQQV9xpwuNE9zWdVkdhpw9eB4GnFURUMPOmbpx7rQ6hrqIvdGE
         tFg60qH8FDwhMDnvnM+Bn7klGAaWJ6EO2ZhsvzdIyqShx87tstsyQPcWzhtZ8HJve0h2
         tYN4X1zQ81vExERAoDxEMME14BBr7ZRQcyapLZpr8vxNJIbBgLIWiH9ndP4Q8qFr4/JX
         WKgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789745357; x=1790350157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8XqNRBXt/qlgUXB2hfT5CeqtG8EouGcWeggFZCzuyw8=;
        b=EGyfsTX7yaqXV2wlkd4EWUDVlAnlAbZ+W1lWCCDFOye1Zjgn4bsNMhM/stIhBghb/z
         dz9Qn5OsR2sfE5h7gkZJg2T24BSdmsJBB8MWt7OqcfxvSfIRaS9FasDy+C/nWRRW1wfq
         4JFYGmLnJRMDTnwe1Rj7tNULQGy3HS83S0hicPRDc6t5KgyRBkNzDiVGtoBFB/ixuyUo
         Y9vb+oScvafZpqipqszjKEKjQhXAQol8F18cWZZFEGEui6akLP5ygN+DX+UCTP+ReUwq
         7I1M92GZio4TaCNMNUvCfOvBvsqGX0RiMXPl3JE72HoYO18UYLGtZ+bTGiRW/kX543Kl
         +CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745357; x=1790350157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8XqNRBXt/qlgUXB2hfT5CeqtG8EouGcWeggFZCzuyw8=;
        b=LHCKSOBcEMuc425DuzWZa8xzXuqgjfy/X4qasoFr+WQVZpgsab+/cxDSZTRXgaHEYz
         HpZldiHdg6o3l1vN3DUZvLlkG1g+8c4X96VBcrccEydtcJH6tjyUuZvhix8a4j9r+KuD
         5bWiGY8cfpzRJNG+iZXNsgSNjw46yZVyzcjMAck0ODEQhWpMxjG8kgREKY7RgQSVYGXU
         dqYczTzrfApIzc7ARYjMc6g7rcKFCT7cYoKYsNZJo9i7D6sqn3MQOSYGexIbrI5+gDaC
         dwTFJSip1nklx/NRPPOA1HGgzfEp3DVd5x1LQfrsxTzMdhf1nCEEmGfWLMECzusPS3tY
         fiTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGFwIXgR5hcfLR87omqLErd91fV5d520IeBoWboSMUTFOfTbKeHUC6rfx5HGTM4woBnHEyXgA=@vger.kernel.org
X-Gm-Message-State: AFuF++ktTeJpeKX0dYKU6xi+AlaqM+NEMoq0wPAM7Q2nea6wImsdRT2q
	HpF3xwzOg1+HGCZfFoJmq2k0zh8AiuTf9hlUCi9v1kNY1T62czQq6OP2VoaBiMLiX9BaPPHeym8
	pgbATvHnSMpObVqCOzVlBe09fJVJ1btE=
X-Gm-Gg: AYBFou1aZO9Imz6y6MfQqd/CLZcLU0pcRwN9P+FKzBMvDnpuAJswSqmTpzfRrZW23MU
	BS4Qjrka2hjdWoqe7c3PmtbwGR62dMFWNRDVcN4ValAYyuHGYhMVTCZMKhAU/X0T21jywvgR9C4
	S+3pfIAhdnaspMlOVN01WIUW9ARPKI0XIr9c5Arj5jfpdLPYOh84b7xfJZhWl3GTy2QOkseWUKr
	QjdxfjHocitHYVNshGdsN2s9sLvDws3geamAuE8pCjEnVi90F6e0tLeHiZg0825/LkV8zM3QJo4
	ExT5j09SGaHjdUeMEELJLX/LOTN8eGilix5Fu0zNYlf3Quu2J9nG7z0Yy+SouwLsGQ==
X-Received: by 2002:a53:b10b:0:b0:668:9402:9938 with SMTP id
 956f58d0204a3-6717fe09e2bmr1135076d50.4.1789745356692; Fri, 18 Sep 2026
 08:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915113811.2429311-1-itai.handler@gmail.com>
 <20260915115206.CCEE41F000FF@smtp.kernel.org> <DLIC8P2V43E6.34ICV316K7HUK@kernel.org>
In-Reply-To: <DLIC8P2V43E6.34ICV316K7HUK@kernel.org>
From: Itai Handler <itai.handler@gmail.com>
Date: Fri, 18 Sep 2026 18:29:04 +0300
X-Gm-Features: AcwNN1XbHeUXrVqj5J_uyPI-friMh8cd1XJAXk3bkpBhx8iPzqwr-5cZFOaN8P4
Message-ID: <CAFpOueRGN2TSNo+m3319qn00p-BYn8w7OQ6OPt4XTcVG63-uUA@mail.gmail.com>
Subject: Re: [PATCH v3] mtd: spi-nor: take the flash lock around spi_nor_restore()
To: Michael Walle <mwalle@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, pratyush@kernel.org, 
	linux-kernel@vger.kernel.org, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	takahiro.kuwano@infineon.com, richard@nod.at, stable@vger.kernel.org, 
	miquel.raynal@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:34=E2=80=AFPM Michael Walle <mwalle@kernel.org> =
wrote:
>
> On Tue Sep 15, 2026 at 1:52 PM CEST, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [High] mtd: spi-nor: skipped flash restore on fatal signal breaks boo=
t
> > - [High] mtd: spi-nor: shutdown hang due to ongoing erase operation
>
> Does Sashiko have some valid points here?

Here is my perspective on the two points raised by Sashiko:

Signal Interruption during Lock Acquisition (Issue 1):
Sashiko's point is valid, though this scenario only applies to RWW chips
where spi_nor_prep_and_lock() uses wait_event_killable(). The window
for this to occur is quite narrow (e.g., sending SIGKILL to rmmod while
an operation is in progress).
If lock acquisition is interrupted, calling spi_nor_restore() without
the lock as a fallback risks having the command silently ignored by
a busy flash. However, it may still be worth attempting as a
best-effort fallback alongside a kernel warning log to notify the user.

Erase Duration during Shutdown (Issue 2):
Waiting for active operations to complete before restoring 3-byte
mode is intentional. Interrupting an ongoing erase or write cycle
risks corrupting the flash or leaving the chip in an undefined state.
Allowing active operations to finish before teardown is standard
behavior to guarantee data integrity.

If this rationale makes sense, I can send a v4 that adds a best-effort
spi_nor_restore() call and a kernel warning on lock acquisition failure.

Itai
