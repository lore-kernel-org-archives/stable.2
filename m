Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70634F3934
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014051; cv=none; b=aVgFma2xtjZ0wU3ESFXiXlytsOMnVqRzNl6E0bAgmBf7lRX/uawzNC/YA8B+aW0mtTCBhGoj2TNXyrldoGKnKL+pQ3zmxz6xhpz6ywhGr8Z/ue6K4Y2jVRgiFhC34lzvMSR1iF7ZS0QsDU75vNU0yScUr3ncQO4eLWAo+WEvBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014051; c=relaxed/simple;
	bh=CXAb4qXyR2HfG3h9rl85FbZFF/8Yznox3qCpzfz2vLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDbsxokmLcwoRDWqYK7ejpeFXu1aPonBb5Pa/ioPR7DWAulDgXGb18DPaR9BioP1Z/rCtnanczucuSptL6K8htTpZK4gijtgiIBq0D8bRqSs6Q/aagC0hXNFSV7+zB4j766bqxEsrWaSJSGqyN9vfL7weVdVv/WXoskydYAEXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwmKbVo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwmKbVo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F311F000FF
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014049;
	bh=CXAb4qXyR2HfG3h9rl85FbZFF/8Yznox3qCpzfz2vLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KwmKbVo0csnD4CmZHT5I4JlGgwZz0kbNccMAmxxOhOHxFof1fwqdDWo2aSHrIL53T
	 HAO53hejB/8hedynkRgQJII8/yNDXorvZeBIn1tfrR7s65FFWSCqnVWIL9oXfmXkv+
	 aLOOnoEZFsHPIBCd0J+UgcDbaBl8KE0UHXrOHWgAhXHSieOkx8oUCviTjMBIDlPf6+
	 hi0DlflroupOUR+NBkgrT2nXpmCVHtnP55A6gFCQ2uaT+YH9Q8/ivFFnVxcb5uyobo
	 x78vn1XquG/M9pbaoeXM8hoV2aE7KcgzdAg4Rr5P7EpAzAPQZ+CdmCK8GT2cfOmfbV
	 zHgC8tu/PMH4g==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a5a0703ae7so1206091fa.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:07:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx411HQJtqo4Sm7P4Ze4owNUafawHhjBv+q+kZUICt9ob+BLMMBdqZBRG/z5Rw6y+SIziBfqig=@vger.kernel.org
X-Gm-Message-State: AFuF++nUitvARNReAFTsT2KX9QKqgk5aPfcrXtqUbt2N8/2bZli0Njdg
	8jBtG7wFSSVQS+RMx3Fy4cqkESrr2qZjAUGtZDT+BW3sQw2Wf1R0fGV1ega6yuvLSXxnfapgHPo
	fBgkIbLVdI4RJhqtK9dRbF6F8FwT7JPw=
X-Received: by 2002:a05:651c:a332:b0:3a3:61ec:43c2 with SMTP id
 38308e7fff4ca-3a624db5e2fmr1038641fa.19.1790014047909; Mon, 21 Sep 2026
 11:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <905771062.272724286.1789919301858.JavaMail.zimbra@trinity-net.com>
 <CAJZ5v0gg7kBtEhagR9SYKaPNstPC6aSyP7W4xBjP1r-kzbcH1A@mail.gmail.com>
 <arFe7-xa3HtCUOHs@mail-itl> <750088883.289173062.1790012799166.JavaMail.zimbra@trinity-net.com>
In-Reply-To: <750088883.289173062.1790012799166.JavaMail.zimbra@trinity-net.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 21 Sep 2026 20:05:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0geSD8ig9_kcrPZp9FEzF+Oh34HV4F_aqyGF89TYVjDzw@mail.gmail.com>
X-Gm-Features: AcwNN1V_NwSYYWm7WSWXzLbFIgtKPrMvHv-S_2NNL56zDEZOELuQBCN1u-UNlmU
Message-ID: <CAJZ5v0geSD8ig9_kcrPZp9FEzF+Oh34HV4F_aqyGF89TYVjDzw@mail.gmail.com>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks
 bare-metal Xen dom0 boot
To: Support TRINITY <support@trinity-net.com>
Cc: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, regressions <regressions@lists.linux.dev>, 
	linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	xen-devel <xen-devel@lists.xenproject.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 7:46=E2=80=AFPM Support TRINITY <support@trinity-ne=
t.com> wrote:
>
> Hello,
>
> Thank you, this matches what I see on the affected Alpine Xen dom0
> systems.
>
> I also tested Linux 6.18.52 with processor=3Dnocst on the Linux kernel
>
> Result: it still fails with the same black screen before dom0 userspace
> and networking come up.
>
> Marek's trace looks consistent with the failure mode I isolated: the
> crash happens from acpi_processor_power_init() while registering the
> cpuidle device.

I think I know what the problem is, see

https://lore.kernel.org/linux-acpi/CAJZ5v0h4giv53a2mPvJYT=3DfvBTj7vVXs=3Db7=
+qC2Q2L35qSTOSA@mail.gmail.com/
