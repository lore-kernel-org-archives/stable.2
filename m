Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F64266AE;
	Fri, 11 Sep 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159510; cv=none; b=SgcXxnWCNNDiqNndPSnItcB10Rd1T5vTQHStq4TxB6zlTJGlcjmVjai+W7OapDxmSQF9+EBqZ8/IIefsM4j/c769z2BWcb/vwGQGKucAFhsUgo2ddIRzH6++sd53vn8eqSrv+QndwW6+nlAJrDAdu9EXsfLYuigog8nFt7P1Fr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159510; c=relaxed/simple;
	bh=xF+oq6oJxQHpoxxPvzaT47kloXMmUw+UiG3lA/tDFBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrDlbZ1OPx9b14m4/x61yluPRZ6S8He7aO4sVwyvrBCbDJ+BzTqz+IvAqXcZE+FOrAYkZWOcasK5stpF5zZpZHIu/tKMcRNB2dxRawhZJrUOxTipHpmh8ZUI6BNTNebHtsIFCjHtnBiAhSPWymVA/q58bUccjzOVb7UiNP1x+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hwdVCksI; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hwdVCksI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789159497; x=1789764297; i=w_armin@gmx.de;
	bh=W3J1Afr710NH/lVRDi7/w9XoM73/On1sn95NXzQ2uD8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hwdVCksIIkMhZnTS+bkb1x4/Vr7C0/IlYcJ8DyGg/aus+pQrrCtnM8ABdlILh+C8
	 rRiet9/UD++xpqVgrg6qpm77/h1vGMWRACQ0aRSJIAYEtMdJ0a7eIhyjY7naEJK9V
	 ZIijLxRm7qszFM5hZH8VPH+xFRGQ/Ns1TJB+vU1DMF3W6hdQ0ISUXn/TewUX25pRN
	 nuwASiRwnyYQw6qMC65CTxTbQdmMn64YWrjk/slPG3WmPBygmPdKpIP1XLPTh+xgY
	 0hW7oEFgb6MgoNoW1JlUjMSTQlLweFlXI3EWUPOWRIdejrPyCEek9IknygvVZEYlA
	 JLmqJnghIanjGJBpPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1xDpHM2ia8-00Rtdo; Fri, 11
 Sep 2026 22:44:57 +0200
Message-ID: <de81ce50-a55d-4a02-85dc-419bb219cdf1@gmx.de>
Date: Fri, 11 Sep 2026 22:44:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: bitland-mifs-wmi: Don't abort suspend when
 platform profile access fails
To: Chris Taraszka <chris@miget.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingyou Chen <qby140326@gmail.com>, stable@vger.kernel.org
References: <20260911182131.461415-1-chris@miget.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260911182131.461415-1-chris@miget.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ht/OV5Z6jzFVtc2EKfqbFsYRMZMJH8Lv+XqGV6V91llXn2DS1We
 NtWjUaEW1OxEVdpBtwDoFWeZMoOaLcpGE+T/iqzOXt1E1ZiMVhsiQKEp1e9h/3GNUASqoTn
 sMg/OoqbQ2wh5kZsieZVz3lwqWfEb/TsVaMniZ3OnlmbJY/ylD4W0DfMOO5ut7uA6cWCov7
 s0f2sve94bhgFNQATQRXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h0L6VAZjK48=;cuIypHuy8utZQ3dOw5hxzoKNvwK
 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
 YNKU

Am 11.09.26 um 20:21 schrieb Chris Taraszka:

> On a Xiaomi Book Pro 14 (BIOS XMAPT4B0P0909), bitland_mifs_wmi_suspend()
> intermittently fails to read the platform profile and returns -EINVAL to
> the PM core, which aborts the entire system suspend:
>
>    bitland-mifs-wmi B60BFB48-...-4: PM: dpm_run_callback():
>      bitland_mifs_wmi_suspend [bitland_mifs_wmi] returns -22
>    bitland-mifs-wmi B60BFB48-...-4: PM: failed to suspend: error -22
>    PM: Some devices failed to suspend, or early wake event detected
>
> The WMI method call itself succeeds. The WMI core reports its own
> failures as -EIO, -ENOMSG, -ENODATA or -EPROTO, so the -EINVAL comes fro=
m
> laptop_profile_get() when the SystemPerMode value returned by the
> firmware is not one of the four documented modes.
>
> How often this happens depends on firmware state. On a v7.2.2 boot the
> query failed persistently on battery: /sys/power/suspend_stats reported
> 4628 failures against 2 successes, both of those on AC. Because logind
> re-issues the suspend while the lid stays closed, the machine looped
> awake and drained half the battery over one 8h42m lid-closed period at
> ~7-8 W. On v7.3-rc2, whose driver, WMI core and platform_profile code ar=
e
> unchanged from v7.2, the query has so far failed only right after boot,
> when power-profiles-daemon first reads the profile.
>
> Commit d3666875c75e ("platform/x86: bitland-mifs-wmi: Fix NULL pointer
> dereference during suspend/resume") added a !data->pp_dev guard, but
> that only covers the event device. On the control device pp_dev is
> valid, so the guard does not apply and the error is returned verbatim.
>
> Saving the platform profile is best-effort. Failing to read it should
> not keep the system awake, so warn and continue instead, in line with
> that commit skipping profile operations rather than failing the
> transition. Do the same on resume: laptop_profile_set() returns
> -EOPNOTSUPP for the performance and full-speed modes without DC power
> (see Documentation/wmi/devices/bitland-mifs-wmi.rst), so a profile saved
> on DC power cannot be restored after unplugging during suspend, which
> would otherwise mark the resume as failed.

Hi,

i think the root cause for this is that your device uses a different set o=
f platform profiles.
Can you share the output of "acpidump"?

Thanks,
Armin Wolf

> Fixes: dc1ec4fa86b2 ("platform/x86: bitland-mifs-wmi: Add new Bitland MI=
FS WMI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Taraszka <chris@miget.com>
> ---
> Tested on the same machine with v7.3-rc2 plus this patch: 11 s2idle
> suspend cycles, including lid-closed suspends on battery of 7h42m, 4.9h
> and 75.8h, and repeated pm_test=3Ddevices cycles on battery all complete=
d
> without errors. The failing firmware state could not be reproduced on
> demand on v7.3-rc2, so the new warnings have not been observed firing
> during a suspend; the failures described above were recorded on v7.2.2
> without this patch.
>
>   drivers/platform/x86/bitland-mifs-wmi.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/bitland-mifs-wmi.c b/drivers/platform/=
x86/bitland-mifs-wmi.c
> index 3a37318..788ef14 100644
> --- a/drivers/platform/x86/bitland-mifs-wmi.c
> +++ b/drivers/platform/x86/bitland-mifs-wmi.c
> @@ -305,22 +305,31 @@ static int bitland_mifs_wmi_suspend(struct device =
*dev)
>   		return 0;
>  =20
>   	ret =3D laptop_profile_get(data->pp_dev, &profile);
> -	if (ret =3D=3D 0)
> -		data->saved_profile =3D profile;
> +	if (ret) {
> +		dev_warn(dev, "Failed to save platform profile: %d\n", ret);
> +		return 0;
> +	}
>  =20
> -	return ret;
> +	data->saved_profile =3D profile;
> +
> +	return 0;
>   }
>  =20
>   static int bitland_mifs_wmi_resume(struct device *dev)
>   {
>   	struct bitland_mifs_wmi_data *data =3D dev_get_drvdata(dev);
> +	int ret;
>  =20
>   	/* Skip event device */
>   	if (!data->pp_dev)
>   		return 0;
>  =20
>   	dev_dbg(dev, "Resuming, restoring profile %d\n", data->saved_profile)=
;
> -	return laptop_profile_set(dev, data->saved_profile);
> +	ret =3D laptop_profile_set(dev, data->saved_profile);
> +	if (ret)
> +		dev_warn(dev, "Failed to restore platform profile: %d\n", ret);
> +
> +	return 0;
>   }
>  =20
>   static DEFINE_SIMPLE_DEV_PM_OPS(bitland_mifs_wmi_pm_ops,
