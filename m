Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047855C336
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090524; cv=none; b=buOfp4ee6nGYPiEs2xVuNDnCiLL3860VRcfBk1YxeExdf91QrvxdHkE5tlpLkSuj4xvS6Tgib4eDRikBqki1X72vLEyB1qwuDuLvqtNHulSa9dhpJlNh7UzfZs9X9vugLvFDe8CfOuXwIr09Mnu/sT5ELugY5aBM0FFKO5oI+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090524; c=relaxed/simple;
	bh=VRKe1XVOWIZ80XXfpgmNp6PGDZIi+vf8u3E/lMWMQSg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FQZNDmAX62oTxwmXVQTdajV8mIPU4OJmssCpPWLub5K7uCBQgVeDxSJzmkfn5rmZUyqaUzf0m4fEgSXFhz7gwy7VkUagk5csAeHQFVZnJDu2Yrssh4z8l1Wygc3VFNoPxDH94KHchLadIy7+1LHDEJdANlIxJphtH2LGuInBbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=T2NFGF4n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQQX226/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="T2NFGF4n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQQX226/"
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F8947A013E
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:55:16 -0400 (EDT)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 14:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1792090516;
	 x=1792176916; bh=OEdjkOEW5c4cRoaBZmL7FvMiAbrODiA1B2MoWuVmFC4=; b=
	T2NFGF4nUSggg4YF8r6ze+uzVymylRxNLVeJ6aSnYDBTqjBQO1nqnwVmPDlJAOrA
	YFMS3eVy8ikfsjtp3yrN2tEfFSLtVPEFqAU/Jf3bZaroIr2daKVFY11V4Ak4f23f
	6krZlasTN0YAnlmVJGeRDi/RKlXlQhSc7SHdIl4l3JiBc7qXOmuk4SUiNPSodpSB
	xmo54cror+gWIR/iN12DiDHhxicc8av9kwUzme4bj0nmoUj2tSn5kAv6QrUy+c6O
	EE93NAWKBJbVaLigLloKgOuoS00UE7v0o/XQwZU9AvahqI06D35EqqffhUA9xum1
	AT2+Xg1oi2Gab2VSHaenRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792090516; x=
	1792176916; bh=OEdjkOEW5c4cRoaBZmL7FvMiAbrODiA1B2MoWuVmFC4=; b=a
	QQX226/l0Hbc7GEDkjxm1kkvUaJNGiBmHf45exHity78cYn68+tf0knFjZFiUy7Z
	u56KoYqqPaaS+8TXi08lIaA0gZXVfm53FzN7ygwgtSZS0BgAD//gTdR37U0wgV4P
	yBz7u2zUGYdz6PvILTjrQb8xkX2exoFulE6QstN11SUTBaAxDfJYLKcOuWTUeYze
	MQapPBfiodPXKgTjQb5wPpdqgG90YrD/VmxU+ZX+6qroRduX6m8v3B+zgxgxDEKn
	x3TT6b0V15N5TYi0pdzo/Vzzap4ZIOZMuLsJjou8f1OHv8G9ZOLvhMigTQ3Gl2wa
	0T7revDWCIn7Uu1uEHgNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792090516; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:IvA6N/UNjA7hWZiE+5XHHESfSzcEdt1m+M5knKjgO7gcU4A
	Z7SOLiKqEXMkBvjpr5Kb6OYbTNdfaYOd3gBTjmevcpNZ8WKdJsAkibJ4IbLQ/x43
	/lv8yUd2L6jrWv4/C4IoE6O3N3us4k/uqqe4feXIQMJCiJFe3bcigqPTZlomSFyK
	kUYTpgAjG1vS3pNaDloQ85EFOD/hsTKfunSDUB8dGnY3I21TIvHu95OZDf3U/HZw
	ImUfDhul5znc5FfzPBThXxG61kUi5B5kj7ryd2VJ+q72CC1PBRIVZwfX5XUqSbZo
	vy/vs+M7t+LUPAvmIrsGhCIEFKY+Q/vfdu1uJTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gHj3MxgQ3hE6nalsir8l1mYSCiLB6CSFM9xo/7+RYPg=:VRKe1XVOWIZ80XXfpgmNp6PGDZIi+vf8u3E/lMWMQSg=;
X-ME-Sender: <xms:kyHRanfqHLWLh-CmI2wROvttXMcC2KI5ZfHjjRDyhvsL5AYFqM1ucA>
    <xme:kyHRaoCSOUv3_B7wXAOdOKn-NarnDT-TrdEsrDiwlk9rbm0uVThoOEVEZaaOvVyNe
    k_EVFwx9oSiFoPNOa-JNbOCBs0y5BZs1iSwnAFvhbHfJosS94T6mNsP>
X-ME-Proxy-Cause: dmFkZTFMR1FFOVl6Uwi+s+KsJt8XrSUsnWfyBxRDchOefKeEW2SPpVbIae9VP9dpRFWKfH
    KrUrmk2huJ+n0kkNbfWFl5zmFv/8zr+iPXgS1LZpHK3tEN68cJ9a5LmZY3t4z0KdwMXJ/I
    NU5WHQRLVwZkz0C8GbZpvvqg8p2/5OFGd7zbrnKTJcWCZDPAJ6OZWs+hjJ2V2togTLqOT3
    h/+9zWxt+fA25zXSRoOHXdnAhtT28PoVzdpi00fwBmq04hXh5KbS7Agp1laVq0U5g7ObCS
    9phG2uj5l9/34ltfJSQ9oU7oppcMZocxztl1GuV6OgxY/voQNfje5baiJynknvG4aycbW1
    3yjbChiZEHXFYNAOl/ynx3+Kfh0C1or3Sc92cM1i9hQdzD7lNwQt7rsGlu6YmINVb9p9i+
    d0r7Ywyy2c+I5+fR/1iIuVq3HfdqLVPsc7R12UN8gkAKsyohxhueIvc+YbBOKs3S8kKj0D
    AhXeoySMJK9dA4xZkxwWzQ+MIRWNqw5C1+otEZJqN1kgQQK1O38/xKcMyfuvBtzHHHZnD1
    vFbAw3dVXyYj7XAbMvmci2Y534lt81f/W0iClN2Vk+CLenrD7gxWH4wR7f758rKJ9Ybg7c
    zCMDAoZ1V0ldU6xgTkC9rUgHLcUjUqsw+kKAXuzpe770ihiQUD+NI2afQX8g
X-ME-Proxy: <xmx:kyHRahKUj0jq3qwn3_B3Rd0yI5-1LCe28xdaAf1xkO146NrAKua5kQ>
    <xmx:kyHRara9OmMlM4oU0d3WAmQR3n5NxFy0q4kTfhEmSdys1fAORbTH_A>
    <xmx:kyHRajCOirXRyxxzYNaqiv9qS6IsshkYVIw-GkckUkpRktEjv29oTg>
    <xmx:kyHRalZ94nKvi7Pd3LBP7ZPPi_XyLgzOmvQw_N-tbOZkN26OQW1sWw>
    <xmx:lCHRar0gNskaxEVAf_fKEB5BexKxOm4nbjWRQUE29WiWBv-uBWy8ca9M>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 9C7972C0007C; Thu, 15 Oct 2026 14:55:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkRdy0Ls-WhR
Date: Thu, 15 Oct 2026 14:54:31 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Rong Zhang" <i@rong.moe>, "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Armin Wolf" <W_Armin@gmx.de>
Cc: Charles <hanker007@gmail.com>,
 "Navon John Lukose" <navonjohnlukose@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <ebb90b11-34d4-4e69-b8d3-5f62acd6468a@app.fastmail.com>
In-Reply-To: <20261014-lwmi-wmi-new-api-v3-0-e1032bed1c81@rong.moe>
References: <20261014-lwmi-wmi-new-api-v3-0-e1032bed1c81@rong.moe>
Subject: Re: [PATCH v3 00/12] platform/x86: lenovo-wmi-{other,capdata,helpers}: Improve
 robustness on faulty firmware
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tue, Oct 13, 2026, at 3:21 PM, Rong Zhang wrote:
> Some devices do not support LENOVO_CAPABILITY_DATA_01 and define the
> query method as a stub that returns zero buffer. Unfortunately, some
> devices do not implement the stub properly, causing WMI errors
> (including ACPI errors). This was reported by Charles.
>
> The current lenovo-wmi-* implementation enforces the binding between
> LENOVO_CAPABILITY_DATA_00+01 and LENOVO_OTHER_MODE because of a
> limitation of the device component framework. When the capdata device
> bailing out due to a WMI error, lenovo-wmi-other becomes unbound and
> unable to provide firmware-attributes or hwmon/power_supply_ext devices
> for the other functional capdata device.
>
> Therefore, errors must be non-fatal in order not to break the
> assumptions made by the device component framework.
>
> Poison the capdata device by releasing the capability data list in this
> case. After that, NULL list will be passed to lenovo-wmi-other on bind.
> The latter will provide whatever is available, or unbind the components
> if nothing is available.
>
> A poisoned capdata device releases or skips allocating most resources,
> e.g., the capability data list and the debugfs directory. The device
> itself is only used to satisfy the component dependency of lenovo-wmi-
> other and coordinate with the latter about the absence of the capabili=
ty
> data.
>
> Meanwhile, for devices that properly stubs the WMI query method (but
> still declares >0 instances), keeping the capability data list with
> empty data is meaningless and causes lenovo-wmi-other to call
> lwmi_cd*_get_data() to retrieve nonexistent capdata in vain. These
> capdata devices are poisoned as well to save resources.
>
> In order to release or skip allocating most resources for poisoned
> devices, some preparatory work is done in prior. With the preparatory
> work, it also skips allocating most resources for the WMI devices that
> declare 0 instance.
>
> Also identify missing components using the new wmidev_exists() interfa=
ce
> (introduced at the very beginning of the series), and skip adding them
> to the match list, so that all components in the list must present,
> fulfilling the binding requirement. Some devices need this because they
> either do not have the WMI GUID of LENOVO_CAPABILITY_DATA_01, or do not
> implement the query method, causing the WMI core not to create the
> corresponding WMI device. This was reported by Navon.
>
> The new WMI API is also adopted to conform to the behavior of the
> Windows WMI-ACPI driver and improve robustness on various WMI ACPI
> method implementation.
>
> Finally, add myself as a LENOVO drivers maintainer as previously
> suggested by Derek.
>
> Reported-by: Charles <hanker007@gmail.com>
> Closes:=20
> https://msgid.link/CAKtz0s8UYRQYW_0bh=3D0TMx47Axm-W-muEay-r3rqUBS1NHMP=
Vw@mail.gmail.com/
> Reported-by: Navon John Lukose <navonjohnlukose@gmail.com>
> Closes:=20
> https://msgid.link/20260928190901.1369497-1-navonjohnlukose@gmail.com
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Link:=20
> https://msgid.link/9789f452-d7eb-4f1e-8a13-7335332193a7@app.fastmail.c=
om
> Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Link: https://msgid.link/782FE636-A06A-4E12-9563-786374805947@gmail.com
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Changes in v3:
> - Shorten the comments of struct lwmi_cd_priv's members (thanks Derek
>   J. Clark)
> - Leave struct cd_fan_block's __packed attribute as is (thanks Armin
>   Wolf)
> - Link to v2:=20
> https://patch.msgid.link/20261009-lwmi-wmi-new-api-v2-0-402828382679@r=
ong.moe
>
> Changes in v2:
> - Add PATCH 1 ("platform/wmi: Introduce wmidev_exists()") to the series
>   as discussed at=20
> https://msgid.link/83776200-4A60-4756-A99F-D5A3BB4D834A@rong.moe
> - Add PATCH 2 ("lenovo-wmi-capdata: Do not stop the AC notifier chain =
on
>   error") to the series, as adopting the new WMI API will intentionally
>   catch more faulty firmware and propagate more errors
> - Synchronize mutex initialization with release-acquire barriers (than=
ks
>   Ilpo J=C3=A4rvinen)
> - Refine line wrap (ditto)
> - Replace the term "poison" with "stub" (ditto)
> - Add PATCH 10 ("platform/x86: lenovo-wmi-capdata: Do not match missing
>   components") to the series to solve the report made by Navon
> - Update outdated comments, function documentations and commit messages
> - Link to v1:=20
> https://patch.msgid.link/20260914-lwmi-wmi-new-api-v1-0-7a400f2f69f8@r=
ong.moe
>
> ---
> Armin Wolf (1):
>       platform/wmi: Introduce wmidev_exists()
>
> Rong Zhang (11):
>       platform/x86: lenovo-wmi-capdata: Do not stop the AC notifier=20
> chain on error
>       platform/x86: lenovo-wmi-capdata: Only allocate sub-master info=20
> when necessary
>       platform/x86: lenovo-wmi-capdata: Store a pointer to component=20
> info
>       platform/x86: lenovo-wmi-capdata: Defer mutex initialization
>       platform/x86: lenovo-wmi-{capdata,other}: Only allocate capdata=20
> list when necessary
>       platform/x86: lenovo-wmi-capdata: Adopt new WMI API
>       platform/x86: lenovo-wmi-capdata: Register component even on WMI=20
> error
>       platform/x86: lenovo-wmi-capdata: Detect stubbed capdata device
>       platform/x86: lenovo-wmi-capdata: Do not match missing components
>       platform/x86: lenovo-wmi-helpers: Adopt new WMI API
>       MAINTAINERS: Add myself as a LENOVO drivers co-maintainer
>
>  MAINTAINERS                               |   1 +
>  drivers/platform/wmi/core.c               |  33 ++-
>  drivers/platform/x86/lenovo/wmi-capdata.c | 447 +++++++++++++++++++++=
+--------
>  drivers/platform/x86/lenovo/wmi-helpers.c |  61 ++--
>  drivers/platform/x86/lenovo/wmi-other.c   |  24 +-
>  include/linux/wmi.h                       |   3 +
>  6 files changed, 397 insertions(+), 172 deletions(-)
> ---
> base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
> change-id: a504a929-lwmi-wmi-new-api-f5344d48a86a
>
> Thanks,
> Rong

For the series (with the minor typo noted in #7) - looks good to me.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Mark
