Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B8209F43
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747417; cv=pass; b=t9iT+87pubnWdlswwL916pl0XN29iEmWt6NEf4JxRxbhPPXPh3XcE5YoEy0VosDk1fqzpDKjii9/Qxdf6MCJ+FSrA5idGI61QwqsIDU0meRgPy/wkg+Xskfxu5bsKmd4BH5T00D1Z98tBpWifMWIB9IG5p8jeiiv6MvKvraU3x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747417; c=relaxed/simple;
	bh=Vbir7G5U1uaNCQUvONVRUrXkoAxD/zZpwy+1cUqwLTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf71/8uKcUxBlRL/Ci76Ck7VX53zHS+MjuYaUNX5G1b3pB9cQ3YKclTCYvlcMLk810au6+rECSUbbDTMQ3j8NETTyP9zEhE6CF5J90Q3aqljiJcB2SKYUXDDi20EPvJMXWg14h4cq8bdnJNp2EBgv3Zp1ziX4QXB/v5Oqkb1Va0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMLMV+aT; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMLMV+aT"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so5940a12.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 22:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783747413; cv=none;
        d=google.com; s=arc-20260327;
        b=ANTXUxHHraA1xx/okAqvbMWoetyp1684C6XhywOgNtRFFRcXspn1X3JASFwclbI716
         mDaDA/dK3XQNnuZizy/EvQBp2HE63G86dulGMBGLL5Dxd7ynxTFq2eW82s5Kww0Y6UKw
         6SRhPMKjJYv4NHaXxQ2sSV1Jwg1643mc4ach6SPfi+e0uXvEzbIMp4fc0b9NpojN0vq+
         +VX+uNOELjd5BFPhwVh6i1tbi3inuH/QsZ8jqEe7rGDgIovZqCuCqRGqSurhdoP7mfy1
         P/6Isr4S1z9Wq7K8kzUbb3o/+lEPGe2sTKnzVccPhVjwjbTjPiFkLPd2PgyyZQxTzyus
         Ecmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        fh=X9Xijh2E2XA4A8ulbszRMzVmg9O8+Uypf/Ro7Qthobk=;
        b=aJpXlrPx0mYeH6X0w4gL855NL5M3241HMV9pZUK9Sr9A6sOqKpePwCEEL/bKgXfYaE
         kU2maCvWItTBS1Rlxw/QYtOvWZWVyuLXTUoKY7UPq07fJgSPT3BB5/Q27Afy5A6JYwft
         pZlVrKVRrUzVr9/W9OO4PK0meZf2zJsyX8Qbs9Bvc9G3WbjMOCXN7PyAjGbmeAAuWe5/
         afdefrvAiiyH+gwhtJzy4VIUhPtIRCUwVXx8jF7jKzin7Rh3cPf4jU4f1AGBYwrVF1ZE
         FWuqE3PCnucyIdm5MtfXTxHvZlz3s6Va/7PH2usIIveC7xpfAlQHeVEOEIUnSSL/IB6p
         9I4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783747413; x=1784352213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        b=uMLMV+aTWkeWUHipxJyPqLC2MpcMozM30UZCy1jb/ql60bX0tr/2iJAjWKGcYTeWuc
         rBvOBOQF04AjwvOFVSbWvnC8Z5C6zl4df/hbZ1Cyjtczz8dweZCty07TJrb9BqClY1WP
         vnrwQmeH73mLEYg3cnRyrsPLJwnkYIev6mVnyj8de83Ze80EKQThAVSuMYf8012osHe0
         gW8trad3BobyZ4nw3geWCwmmkVGBYrOzKZpywbyj+M/iQ7uSVR2Pajfafm/L+cYkEAts
         vZgYDJbIstw8naA+B1eR7wKyz2hAFz9CshKi2s2lP9+uIXNSqxxy0F6ebq9zlDvZGW0A
         sA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783747413; x=1784352213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        b=BmftI6u1eI0kmDtydGjWqzqQulgib7K/jDvT+/DAZpPjXkaySft9MdqTbI8SRZUWLg
         aUXUZkvc/OE63uTUeHtXQ415h5eCJedZtt/HgRTppviLbqUO6cpmJ+OxWYYWCT7nva9i
         kCA5qnt+mbUQ6rZnQEELpBiyN2Lbt5mQFq44SuHhrsIpGFAL+cc4Kht9uB5eq38v7EeA
         HakVR1WHzESzkc/PsNZ1a+kTEkNqyG5My8txnUJkxw3HDyAcA9tu85LuYVlmScdlTx44
         hKKFoFx163WGeOW2DBBeeMozTjpTTzJAOIK+XjfoFYugGdEgc1/KXYj225W1YpwL8IqL
         LcVA==
X-Forwarded-Encrypted: i=1; AHgh+RqYrH/YtQVpd0FSN05gctKUQuevkzHy+HMtjhgrPHcGOCpwqPKnc9t2I0nNz55hkpN1O/lEhAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0Jyvor1htcOayrRU7s51UOE7QNb8iA8KrpuDIFOtJv2y8caT
	ySi78xXmXehPDhxWYlRioK6T22K1j1XJGuzSAzMlxjettZH81cHpUycAErugYPC4yIVesRZqBSq
	pIUviqDyK+WOgtSmJAsfUa7Ytxb7zHyUmBrJ/LOVr
X-Gm-Gg: AfdE7cnM2ziGKzoVCi62Frw56DUzavRAI0nd87EDU6zXeqEoRB/0G7LiWNpF4dIojx/
	eefiW+TRq7ntNxP9fNmIStukmUFhQt8xE7LNCBZFJZEZVb+qaHKqdrx0tUseLdvPRooNq89lij4
	ev872siehy3ejjoPAFdtS2c3dNkCD3msgahFx7t8syC82PNeIL70BCrM0b97n48K+CsEoGOSK3w
	iVMmeaL6qqXJAUZR/M6SeMsjEG7PmWj2fz7xv/AOgmMAN7Ax8/xLK023d89SPVF+hmSUDMjkCGv
	x2dl9c3TzCixhEDFXgmKRpI0r7g6ZjsAh/ZKTBmDJIpVMPLLye9Bo/F5403Dk7A=
X-Received: by 2002:a05:6402:564b:b0:697:9254:a66b with SMTP id
 4fb4d7f45d1cf-69c5f806bbdmr32702a12.6.1783747412689; Fri, 10 Jul 2026
 22:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101635.103005-1-fanwu01@zju.edu.cn> <20260710002451.500112-1-eddiephillips@google.com>
 <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
In-Reply-To: <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
From: Eddie Phillips <eddiephillips@google.com>
Date: Fri, 10 Jul 2026 22:23:20 -0700
X-Gm-Features: AUfX_mwj7DPyIzPgMc2aLdczV-n7IZVIQgU2ji0mGrRtnih3_s-rWd9eqlLTuGM
Message-ID: <CAPBb8HnN2Q2_aMRQ5Tv=pbi6Mz=Qe3CJkAucUx858_+_AW4efA@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Fan Wu <fanwu01@zju.edu.cn>, Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	Chi-Hsien Lin <chi-hsien.lin@infineon.com>, Wright Feng <wright.feng@infineon.com>, 
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 12:18=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/07/2026 02:23, Eddie Phillips wrote:
> > On Thu,  9 Jul 2026 10:16:35 +0000 Fan Wu <fanwu01@zju.edu.cn> wrote:
> >
> >> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
> >> drvr->bus_reset, whose callback recovers drvr through container_of()
> >> and dereferences it.  The teardown paths free drvr (brcmf_free ->
> >> wiphy_free) without draining the work, so a bus_reset callback pending
> >> or running during removal can outlive drvr.
> >>
>
> [...]
>
> >>
> >> This issue was found by an in-house static analysis tool.
> >>
> >> Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> >> Assisted-by: Codex:gpt-5.5
> >> ---
> >>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 13 ++++++++
> >>   .../broadcom/brcm80211/brcmfmac/bus.h         |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/core.c        | 33 +++++++++++++++++=
--
> >>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/sdio.c        |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/sdio.h        |  1 +
> >>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
> >>   7 files changed, 66 insertions(+), 2 deletions(-)
>
> [...]
>
> >> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b=
/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> index fed9cd5f2..b934feb9b 100644
> >> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> @@ -1164,6 +1164,35 @@ static int brcmf_revinfo_read(struct seq_file *=
s, void *data)
> >>      return 0;
> >>   }
> >>
> >> +/* Serialize bus_reset arming (debugfs reset write, brcmf_fw_crashed)=
 against the
> >> + * teardown drain: the remove path takes bus_reset_lock, sets ->remov=
ing and cancels
> >> + * the work under it, so a racing armer either schedules before the c=
ancel (and is
> >> + * drained) or observes ->removing and desists.
> >> + */
> >> +static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
> >> +{
> >> +    mutex_lock(&bus_if->bus_reset_lock);
> >> +    if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->remo=
ving)
> >> +            schedule_work(&bus_if->drvr->bus_reset);
> >> +    mutex_unlock(&bus_if->bus_reset_lock);
> >> +}
> >
> > Is this safe in a softIRQ context?
> > mutex_lock() sleeps until it can get the lock.
>
> What softIRQ context? brcmf_fw_crashed() is called by PCIe (thread) and
> SDIO (worker).

Yes, you're right. Since it's thread/worker context, sleeping is fine here.

> >> +
> >> +void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
> >> +{
> >> +    mutex_lock(&bus_if->bus_reset_lock);
> >> +    bus_if->removing =3D true;
> >> +    if (bus_if->drvr)
> >> +            cancel_work_sync(&bus_if->drvr->bus_reset);
> >> +    mutex_unlock(&bus_if->bus_reset_lock);
> >> +}
> >
> > How about if brcmf_pcie_remove() calls brcmf_bus_cancel_reset_work(),
> > takes the lock and calls cancel_work_sync(), sleeps. If debugfs
> > path is already running, it can invoke the worker thread. Is there
> > potential that both try to reset?
>
> What is "both" here?

It may be possible that the worker thread is running and then the device is
unplugged, causing a deadlock.

Another possibility here would be to just lock the state change, but both
implementations should are fine.

Best, Eddie

> Regards,
> Arend
