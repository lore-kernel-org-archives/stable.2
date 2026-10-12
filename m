Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EF49C4C3
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820262; cv=pass; b=AJku0j2tqCFmbVQd7aVrQZv9GqjSOGbkb+MnqKAZuXrWjy/QiQrfGZGeWgmBqf0YgsS6GIFREsoGSJClN73nZUPcvnJVQOsSC1uldLfFUC9EiLCUtp4U7qi1OQKOqfOFoF/qqv+wIP1O6Mk1xV9DKZlSbUiQumdM0aSBu0/1xmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820262; c=relaxed/simple;
	bh=8i+vVvmrpDLXIT1xlYKC7kLshWLABIiaWSSfEQK/UFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCgGR/R/n+yKXhHhBz8gltranNobXPz5ohKRT5/+vrlkEau7riS85cefW/9CNhPiiaXWQ0Ahz2CHS3wsDT2+W8kqJOCZkQ7IoHnNkeJQRwCziEL6OopthlEvZeYI5kqdPt85Q/Yf2xRl1wMcE3acw4oaQgv8pmc8rnMLo+G7qog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=xiFQ1X0x; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="xiFQ1X0x"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c169ae1cb26so719935866b.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791820259; cv=none;
        d=google.com; s=arc-20260327;
        b=kXJCh8LuoJtk0ePhsu1dIhg5MjHemFi4RA39FlMbUuyQMkrSsV3vcs4VQDo5GnDlrJ
         SIVgad0qt/ZE4LLziwObbdKHXc4wBRyPNk+nv1b7Ghkyfz8iXQL4ryjnD2i8phpgN/mh
         4bJ/TGj9WwcgZjPTXxp4PRuv1uQpAZBZ9zn3gg6+dobl8i15XfMK4WtqmiTgBqhZxylT
         LAU68PRl0DJvcntDylUOWAHqHpMZ5yW7blPDnVpB0e0QfMQtYgfcTOTrdVWU97aVs3AQ
         +Sg1T+HKo45a/AxGIcCQ2apUSXUzGL0bX3SWrMWQ4VoKzTIyBHBX9CUDVcyoR7peVuPO
         l06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8i+vVvmrpDLXIT1xlYKC7kLshWLABIiaWSSfEQK/UFI=;
        fh=daHICPhLbslYuMJ6XcXQMg+Wtp7tmNlO1mL61Ng1rN0=;
        b=I/5nOwydkGifUzxFb8huEqHQBi4UOPt22JIOBQdikr0WOmA6gQnnkUKI6U4SbJ/kDU
         tu3jDV55R62uOT/+/k4d4EcZzfo6Bqq3inXVJKNCTtWfHmiK55itzBjHFKU23v4zCI9U
         HumTUkTb5pa9ucbP853GjKeCdSan4bGmETsQsNQ0qctsOoG/X+84PN+GG5lBNl8LGkF1
         lM2GgbOoCEesBBwh/X+oUTeeNLnlm0MWCA+d1TqJbN66GxtfLAR0BWEOET+QOOU3WSUf
         RqpkyQbQuUhNEFYh0qnJ/fTFuUNu7g+E8DEYVqvaLmKLHAhPUKo3KdNEr+0OdJJnILQA
         FFkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1791820259; x=1792425059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8i+vVvmrpDLXIT1xlYKC7kLshWLABIiaWSSfEQK/UFI=;
        b=xiFQ1X0xvOfVywxh1z8+CAeE/jayRCAtDwPL1rPzeIYFVL+cuHbFbVYRtIBqaMhdmK
         +cdxr+G8IGqo7OicX7Z/hy7Fd/OVFHclNouwUEy1rXP8qbMSLoQv+f1eYasCkSfNFVqB
         VqVYBqSMfDIbc3zmojAfQB8bsztfQMonFLQv3wZv+UnHJW0gUj60Ns1hvVyz9u2agjdf
         NhOvf57jhc9HXB+Ps7f0Z1ZWJmWLNN+OAMbIDwti1KQLnVDyr1jP2EnQtH4+gSAFvdXw
         G3hsNU49Q5EDTXkaWexTmOBKnf3iyz1fHBq5IwcYNVM4ryPo5nYIk50tACp9v252zmM6
         a9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820259; x=1792425059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8i+vVvmrpDLXIT1xlYKC7kLshWLABIiaWSSfEQK/UFI=;
        b=I1hETikCtpNa5npUvogLMHDoif+vu2bf0MgdKRI+9i5VUdJG4HKAqJqOpMg2Q+QuHq
         0hThQfcRAWUs45W8YMZ6Gk4NUKYmbanGd2tfUjPrOOhLUgfv0DxWJtGw9WCSrgeXXcPl
         NObaHXFyXig8EWG+FpTbRS3eHcGeP0WlIGCjL98OnGLuqKCcKmyUDyNQpn4so5yWoywB
         YifgpXROSIsn5LhykbsvwjrOlJGyn+fixwlj2rEydf5rCXIe6fXJJ0/87UXHUuNvqop7
         YdD9GN8RGi3ZQnnnMdKLL6HOwqP48pvaRydbBFSnOxnxiziWQE1XmkioJ8Iprdw3IMAa
         tXGg==
X-Forwarded-Encrypted: i=1; AKwUvBxlyXlfMXA85/uxyO2LoYrigN+m7Ow46zxLSvawP7JHEHc+Xh90FoKf8WUVIjUL7HNqlV9oPps=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvl+/HqR1ZhohMUrif///PUjl7cjV/Kxiy3mCDMPjlQwtN8x+G
	K3SKdU+vxNBinAgzmd3czKX0B4ZxfeFAsOzQC1esm8VPug/Is5rgwGyP4C5a+viTChVHJhcUJzZ
	SoOg6jmWebyC+xCBAMAi0itvkASLvfVfN3cnsEpexCg==
X-Gm-Gg: AYBFou2g7GsFSbFRZsod3thC9jdAtdRlEWC82ZxaC9Vfm290NEq8aANwElvWBRfbPR1
	CZfGnr2jwixAGvJw5eaAeZ3IrVrGqgoBSvGQyxa6EORBXFytatBixiWN9+bocUcX1HW7jw1Q3Pi
	crClwRFqaoVUfHbgRzXE9knKkdJJIBvM3Eckz1OfHrDaKa/z0C/QChABfJN5SISemT83ZQrFVIK
	7F8Ti1JTnx0wb9g2hWw4I8XTk7v6CR/ejH3tphi++b7BRKrYhXCo5Q6wR4H7GcA/qH4x82Wkvot
	dwc5E6Q7uv4M1xVZ/MWHmAvyBx47vCXrJjzrv9dnKC6PvRpLqrsr/ei10GWgoWco+8PfaTfwDNG
	QSPdH1Ojvq5TMtnzyBuh0iQ==
X-Received: by 2002:a17:906:d54f:b0:c2d:c6e7:9e9a with SMTP id
 a640c23a62f3a-c31a9d55799mr1035064366b.11.1791820259105; Mon, 12 Oct 2026
 08:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026101214-playmaker-poppy-55c5@gregkh>
In-Reply-To: <2026101214-playmaker-poppy-55c5@gregkh>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 12 Oct 2026 19:50:48 +0400
X-Gm-Features: AclHuK-vtMDu5GKrIcOczB7KV_PN_shv0d02XkRYPwWqpQqEgh32i7W23OSasKc
Message-ID: <CAKTNdwHx6eKg9ghAKZf2omzG=r9RmTL=Juk4YWjk+=sOd2y2wA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] regulator: of: fill in supply names in"
 failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:58=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I've checked, and there don't seem to be any in-tree callers of
of_regulator_bulk_get_all() in v6.6. So I suggest dropping it there.

Best regards,
Alexey
