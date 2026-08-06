Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139D442B15;
	Thu,  6 Aug 2026 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015130; cv=none; b=XpS3rf9rj6Bd1UMwoK8AfCiLW+U7qTPgaNjb/soXiGuwJsz2LqQVkOeBkqTadSfr/SKEMgG490mXAQv3rlrsdiKHw54/6ld9VsvDQfFV4N6MyggCGACVPWn7s5FUt88AGjFehsAZdX1U7XUnn8Fd87XHKPX3vzVdJDqtXL4+dUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015130; c=relaxed/simple;
	bh=zew8gWZJiSm87xDe3gmKMiiYWY8aeEKTxjWd2gGwSqc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=swQWgHiR6LjOA57g63FwwATygRygd/awKfDEwu+lPBdWbL0nALGOAFGlM+tRIHUN0O8cNXoqYhJZ+7zcPeJlzIQQQ3PRQCA5R1e9a+fks4bOJjLfaYB1keVx2fxGhN7uy1eR6LF+fxmvlwW9qGumtjyYKll+qBr7hNj5AUwa0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NiLWDPkC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NiLWDPkC"
Received: from monstersaurus.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 488BCEA1;
	Thu,  6 Aug 2026 13:17:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1786015053;
	bh=zew8gWZJiSm87xDe3gmKMiiYWY8aeEKTxjWd2gGwSqc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=NiLWDPkCH9dTWRCcBj+g8A4nHs6evhohSeSUTBtd3KDl7ENK8rtclZgy1ynFUqNP8
	 d5SxebdwvXKhVrSm96YbzGOTjmK554P5SfuQIML1jMf7EuJzi/9X32efdqkw6tEXul
	 RkLJrJEfZbF7qYm2l/8uDilDt4I23rCJGU57bUMA=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <anRauS-k_PTOdrZa@kekkonen.localdomain>
References: <20260806061804.1359700-1-serin.yeh@intel.com> <178600597076.2317790.15882507123821898906@ping.linuxembedded.co.uk> <anRauS-k_PTOdrZa@kekkonen.localdomain>
Subject: Re: [PATCH v4 1/2] media: i2c: ov8856 : remove ACPI node bypass mechanism
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Serin Yeh <serin.yeh@intel.com>, linux-media@vger.kernel.org, jimmy.su@intel.com, sarang.sapre@intel.com, bod@kernel.org, stable@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Thu, 06 Aug 2026 12:18:41 +0100
Message-ID: <178601512188.30573.7636551351503669599@ping.linuxembedded.co.uk>
User-Agent: alot/0.9.1

Quoting Sakari Ailus (2026-08-06 10:58:17)
> Hi Kieran,
>=20
> On Thu, Aug 06, 2026 at 09:46:10AM +0100, Kieran Bingham wrote:
> > Quoting Serin Yeh (2026-08-06 07:18:04)
> > > On Intel platforms the sensor is enumerated via ACPI, and an INT3472
> > > "discrete" companion device (the power-logic-control driver under
> > > drivers/platform/x86/intel/int3472) registers the sensor's
> > > reset/powerdown GPIOs and the regulator supply. These resources are
> > > therefore discoverable and usable through the standard gpiod/regulator
> > > lookups at probe time.
> > >=20
> > > However, the driver guarded both the GPIO/regulator acquisition in
> > > ov8856_get_hwcfg() and the whole power-on/off sequence with
> > > is_acpi_node() and skipped them on ACPI. As a result the sensor was
> > > never powered or reset by the driver, and probe failed when reading t=
he
> > > chip ID in ov8856_identify_module().
> > >=20
> > > Remove the is_acpi_node() checks so the GPIO/regulator resources are
> > > acquired and the full power sequence runs regardless of the firmware
> > > interface. The driver now behaves consistently across DT and ACPI
> > > platforms and initialises the hardware correctly.
> >=20
> > The calls to get GPIO resources is 'optional' but regulators aren't I
> > don't think. Is this still ok ?
> >=20
> > I think it is - and we can't run a device without the regulators - but I
> > don't know how it works in ACPI land.
> >=20
> >=20
> > Sakari, could this cause any regression ? I think it's ok - I just have
> > a niggle of worry here in case there's something I'm not seeing.
>=20
> There should be no need for explicit regulator control on ACPI systems,
> however the reality isn't always aligned with how things should be. So on
> some systems you do have to control regulators, even on ACPI.
>=20
> >=20
> >=20
> > > Tested on Intel platforms with kernel 6.17 and 7.0.
> > >=20
> > > Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor cloc=
k helper")
> >=20
> > Is this accurate though? I don't think that commit caused or added the
> > ACPI checks. Was this just the first line that matched a git blame ?
> >=20
> > I suspect the blame might lie further back.
> >=20
> > devm_gpiod_get_optional was still guarded by
> >  "if (!is_acpi_node(fwnode))"
> >=20
> > before d2fa1134a48b, it was just a bit higher before
> > devm_v4l2_sensor_clk_get().
>=20
> I think Fixes: could be dropped altogether: the patch is simply adding
> support for systems where you do need to control regulators on ACPI.

Ack.


Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>=20
> --=20
> Regards,
>=20
> Sakari Ailus
