Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92D78F2F;
	Thu,  6 Aug 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999368; cv=fail; b=gU9VkIkd+bJPn7OPMB/Xd/3Kqz0X5uMmeR+sot6l/wcmwJ9zCsj7M1RdGNuqrTgUstRGn+fYQrgOgs7Bj1+lz+ZVV3FRM1V+qSlWh9uOPElHaRfdgvFLgSzKRqlVG0BaisXmPya0utfVVvxQdPezD/5NmrJv+VfkrlgwrTqInIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999368; c=relaxed/simple;
	bh=/wlwPt48ojsJUoREPy8dE/36Bqi4w0rIqdJreWGOxVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adxhO2XlZJ8spiJ6K6tbKkQADaS2zW8r2A+fAcHdRaJ7ckyhNDg2PHs3tgCwgt4qavIuO4QBIRcquPtK/fVWzRiQnYe/lyWX/lwe2oGxLQt+NXYOSZf2FFT0bYMga5fejDKfKOwHxmwDzxaZdLwEvQ1J/0hdk8fjdVkbqusJ0C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRgmXIF/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRgmXIF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785999366; x=1817535366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/wlwPt48ojsJUoREPy8dE/36Bqi4w0rIqdJreWGOxVo=;
  b=bRgmXIF/hcYsXTKGuh9b8wbEMsGjcCgUqU20vveucwxc64hNyoR4uTQj
   D+94VV6YUhMN+YgG71Y3SHcGmkKShx8etY6KGr4xsM9UKUEWekIhfa1A8
   zBMpcgeSQC8v92LVwGo912h34Ahjo0ftH0TU5c+2ouCOZlEMchNt6WlBx
   dueDCzHgsl5GDeHmZiNC+CpMCfl6PYl1x7T6Q6xJSn3W0cp0U8eHB+k3j
   TWYLzVvKTSibGOGQ2RczGVCiinG4uErA/607lfTPqX+8AZo3KPL/YDyaK
   cjE95r0MbpXg9Hx1xu1ycWAUipJABqP3zvya1E+IFQdbai0aTe+nb+WZQ
   g==;
X-CSE-ConnectionGUID: B90Iy7oNRFSGPvqByAzusQ==
X-CSE-MsgGUID: 6ngcOntNRteloOtWKm35jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97230180"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="97230180"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 23:56:06 -0700
X-CSE-ConnectionGUID: M48KjQvoRjajhn9CWjHo+w==
X-CSE-MsgGUID: d4y6zI6lQbeBIweEoFMRwQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 23:56:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 23:56:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 23:56:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 23:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWSq1mFDz0zIcn1J+J9ZTKBvSGiRhR1iMi8P3XzOTP+q+VZoHsCELZNaeqLetlaWU501WL72bZPFpGiQNXy0DPxww9l5+utdMEHgtPdcBvxiPdS+LetveiT6dI2y7YXm6dLB05O/FJ3pvFZr0iwux0V2FL/uSQc5PycZrwAbiZESqyb8mO0RZ1VYwf+slKkaZVb+8JvsdFrkcKxtc34AYDne9sIgVoejqNftdB8V13fvWkKOOK3sJG9ktac1fOWh6D/EQ6YmhUujGR0OpcUmhjjNKJiVa1Do1WkEcoR3RpgLlLSlZUB+YI066AOnZU3IdxRXn7hiG+Zl2QyLmJ1uTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwwgp2frBRO9bdd6EJQkFfZflkBAYXSFNCKag1Fn+9U=;
 b=Ld18CCfoV5y9M0qhOkeBzw8UkPjnz+Uy2JtqkeUm5Rcqx02zZiahZlbUy0h8JNwBnI8QS0XYXszZbQCR8pm6X5j7wcGUKtDGAmzNTKgNR5llOGFw2EEZPeYh9Ib85eBpKYGL6s5St7aSEm2MNPuiH8Xa7bjoNQoxFc9J2MBsvH/jdPjbLJJpGAu9WSiEglAxS+lJBuOzI1aa7o4B68v1671ZeoPTsP42C4PB+UNdLmwDRjwPgxKXov6yXZGxK4zXkty+pX1GnmOjLeELc/i9msaTA7s8t1HUIb+JSIZvLjv15w+1+j9AyGvkaVFeJAhA/r+f4RyIHYnbmGgE6spIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7971.namprd11.prod.outlook.com (2603:10b6:8:122::12)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 06:55:50 +0000
Received: from DS0PR11MB7971.namprd11.prod.outlook.com
 ([fe80::40aa:a291:4c25:6e0a]) by DS0PR11MB7971.namprd11.prod.outlook.com
 ([fe80::40aa:a291:4c25:6e0a%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 06:55:50 +0000
From: "Yeh, Serin" <serin.yeh@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "Su, Jimmy"
	<jimmy.su@intel.com>, "Sapre, Sarang" <sarang.sapre@intel.com>,
	"bod@kernel.org" <bod@kernel.org>, "kieran.bingham@ideasonboard.com"
	<kieran.bingham@ideasonboard.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] media: i2c: ov8856 : remove ACPI node bypass
 mechanism
Thread-Topic: [PATCH v3 1/2] media: i2c: ov8856 : remove ACPI node bypass
 mechanism
Thread-Index: AQHdGnXrdRMeMosrPUWn45l84F+ayLaDQQgAgA1memA=
Date: Thu, 6 Aug 2026 06:55:50 +0000
Message-ID: <DS0PR11MB79717CC63F1E828930C24E1EF6D22@DS0PR11MB7971.namprd11.prod.outlook.com>
References: <20260723074036.369363-1-serin.yeh@intel.com>
 <amjuPjYBw5akS06k@kekkonen.localdomain>
In-Reply-To: <amjuPjYBw5akS06k@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7971:EE_|PH8PR11MB7144:EE_
x-ms-office365-filtering-correlation-id: 951b03da-7224-4e70-cb20-08def387c022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: pRPR3uG5PFO63eW8EH80dSeNJ+Al83MKnmR+9toyN46M3JdIbyC67V4QIpFOr/uX84zrO3+KTxtT+CKpjVZVDneOD57hxB4+Ogs2As6LYyYotGLc7KNrqw0uLPe4vMxystNkPjxUslbd11cQnoN3l6K0pgTZ9xva9PVbhfxA/yrPkBgU8HqyatDUqWkgieOm8KCV9mPfb0/Am5Zk2j5gj4k5+E4eqQV5IGPe42tKznl9pAv3MJ+uwnU6NEkWUBd3jkw6w6FoFWPd8AVAsTHQ9qzDGGgxXj4JnXhfpfkrEEaYruk8ZiJ6CaYh+yMhvCsuCjNOagfKCvmmZc61Iev44unvhTFE6ueta0Q6r9neB8PE+bDSL+riI5ruikVUCN6DCCbNz1RDKCm8jyBYlR36W+Xea1HLdvla+lRFNJvYeYHnF/BD+zK9p4No+9fFpwAhPiBJOIVs3DawinWevUCCL1GM7L8cNe6AQXBuxxlvCM79XoJGKGHf7w5YT/S0qC+23UvN79P8ivFB+BUQJIMx2de0oX00IrS/cSbGygw9W59uuNoHrqxxlqxERgcyLDAzaIgpQJc5ZIYYiNT7Q7/JlmU1T2R/nAKndS8GlNUTtckqmUiEV3LkWtJAaOFhf8JN5KslRQwNqpA7KH1GqKDevGmX/qPSbBeDIlkFtppDek9e5edgvM5Y9O2kC9tKsObSyOQbZBcX/BTSTRMFKMEkMQpoq2s9OolkGit3HUW4gqk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7971.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?foUvMsZlwl50rPaDjsLEb+xJiqnWGCN5O0IoKoi14euWqqCCdng8wI8obCbJ?=
 =?us-ascii?Q?jkB5IB5vnzsm//aC3D8d2l/z+PFEXauFFjljhXbAMjk04wQTpz47c4k10b+H?=
 =?us-ascii?Q?CTTuxxiQZ8ocnUCAYAFzIXOspzo9NvjsoKUxNQuLnpdoaOTmcz9oWIljvuuY?=
 =?us-ascii?Q?ym02aKUuLjWwt9eqSBjPQukkLfybNQZb5gKWurY1BRGr6JVIVKGHt5x1iWh/?=
 =?us-ascii?Q?9QpHWLkWZ8icJMiqBnknvGJam8Fzw5QMbkJ0v20laSHf7AEBC2TrPEes3ZqJ?=
 =?us-ascii?Q?BOdOc2rWlv1iKOrt4A9akWhrkjm1xGhyq7nEEOdgJhcEReJpqbTHxPxJQaUM?=
 =?us-ascii?Q?JmHCkrb8F6CAWwJiMx+vIlHl4kGBpe9R2czk9y7/r7x+VN+oPouHGc0LTex8?=
 =?us-ascii?Q?wS3k7nuxnRxe6CaRBhL0O5NbdpETRGdvB9e2l3zgsoGl1vuKSDkKjjeXhcj0?=
 =?us-ascii?Q?pw2uvJLd3K9HUm2WKmIIiQBGUTVAOUUpv7SjMaKv2k2aiUzV9qVOQrTsTn7H?=
 =?us-ascii?Q?tjAoOtZTAwRNk5WXULXQsHQEjEHP3MBSZzStIKFsQfp1S/twVgi/UnZjUARR?=
 =?us-ascii?Q?qtesk2u4lepBRm+mFMZQJ7giRY9IzVk2ZNGTdQ4dGUCMgCiK6llNIbE5ZcKT?=
 =?us-ascii?Q?KOk7/Rxhm4W/fI8EQeRtDYctcYSh5lDml5rUE0+KOTA7bmKOWO5HspHF8nIv?=
 =?us-ascii?Q?pBvnbBzTFX04mRHNrFS/5edrh2Yr/jxCCoObtJhh238aTKjc+XPK3Bt2FTfp?=
 =?us-ascii?Q?77xjwAypALpRL8qmdTQNH22VvhgAFlbo6kbumByQoMSQDMm/nrgMzWUFiAyW?=
 =?us-ascii?Q?/YxWrM+nuiKpmLffSxWTNcRqMWrZllSxrbPmzTps4VhiKpLuHbNpjhcrBglJ?=
 =?us-ascii?Q?+d97PhadNMDLHUjA2PE1i6fZVBAOrbXg45S0BJBe/690E2c/dBhDHN9exEFr?=
 =?us-ascii?Q?Owl2RUvymC4Cq3XPP5O+C4acNY+L4dPiXvkEv9Tl6C6fqYGP8pZzm9/gEAoL?=
 =?us-ascii?Q?RIR9m4cvRGepu1fMTICtTPDg3vc8DGS+5VCzHKI7YY1L2mzfMJrU4BTXDkDT?=
 =?us-ascii?Q?j0jRvLuY0Bh5Rr4pxOMQh04dJHyb51SVhUnyR2uN/IDhS7cP4tn2kR/Ems/a?=
 =?us-ascii?Q?Y5DzsxKAIzjeUpuxqToFc/PY2dTPKT7h+BmzhCIlzJviSlMZUqfe/zuUH9Sy?=
 =?us-ascii?Q?VRmHqJBsb5jV3ym5vkJRH0QQrnuEWEsC8JcFES6sXL/c/GMFuq703yHglQ7e?=
 =?us-ascii?Q?+0Mame8xklb9dKgR6m//NTgVwxDGWjIuFLgIkGV4CVSQf1kVpII97cerpz6g?=
 =?us-ascii?Q?WvVShLHOwASX3C7iMjgbAU5NGYH1aARIthj0LREPXItAjEdTolONri3aIIS6?=
 =?us-ascii?Q?UrAgwP3gnpKdkQVPEvMyy6EaCtLyRz7MZMcQDVR0hfABN5Oij/+0Z5Z2LZAz?=
 =?us-ascii?Q?vw73eNHVRhehZRlYV19I10T3fFa5giAMVzw9empv+FIRJs/07jTbpbTwuGMy?=
 =?us-ascii?Q?SCMzDY3HLcMtIjRMvZaZv63XLUR9IvlRmuSmV0VtoHH8MV4aO9wUW2xALerF?=
 =?us-ascii?Q?KGdKuL9fWixnLkoMRC7ipU7fFH2v3KGbCRWW/DAuE9U801nKcMfIkfYP4UW9?=
 =?us-ascii?Q?gvpKHGE+jtUeSpB1tXFA58l/qbn0w9GDms9IxABxyNCxE5C9jUbnKS4H45kD?=
 =?us-ascii?Q?57WhH+j+7xY2M1IJEuqPu6fvo5ppywnOyvUodaJDZK27ZvJD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Py39P4gIa3BGu2wDK3JnuavrnSjN14Wzz9eYaAvxpn+TyNpH+dOUEEZeFsBdydV/NmCfBgfr5RGCp3kKXhUxZMRS+dbyM8sgMJr9IPTJqypcWGfgVJYMpFTrLzL5V7ASDj9pc5qs0lTUFiUzTL0fv+olT/Yws6gyeYaShRaPgcMGD3OJD6jQkpdVcasHm6L/qOwRuX/pWyF8b0Y8Ux/WB0YuLFxKB3/0dTvlozO2mh9K2VUidwXJdydmQIaQKPIbX+jtL67+kEmVBQ1SlPKmfrVsFpve4KR+QozwfsovUTGFNg4ZmWirwnMXu0EPUTD4Vr0+FAGPjLg9uI2lgRh/1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7971.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951b03da-7224-4e70-cb20-08def387c022
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 06:55:50.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdh+mWRrYiGKkrp2gT/6HXi83jV0WpfSjy2+tBn9nccFcz1ZIhLkn0cyMbW74f6o2EKg9+YndqI9gsEer1+aLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
X-OriginatorOrg: intel.com

Hi Sakari,

Thanks for the review.

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> Sent: Wednesday, July 29, 2026 2:01 AM
> To: Yeh, Serin <serin.yeh@intel.com>
> Cc: linux-media@vger.kernel.org; Su, Jimmy <jimmy.su@intel.com>; Sapre, S=
arang <sarang.sapre@intel.com>; bod@kernel.org; kieran.bingham@ideasonboard=
.com; stable@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] media: i2c: ov8856 : remove ACPI node bypass =
mechanism
>
> Hi Serin,
>
> On Thu, Jul 23, 2026 at 03:40:36PM +0800, Serin Yeh wrote:
> > The driver currently skips power-on and power-off sequences when
> > running with ACPI devices by checking is_acpi_node(). This results in
> > all power configuration steps (GPIO, and regulators) being bypassed.
> >
> > Remove the is_acpi_node() checks to ensure that the full power
> > sequence is always executed regardless of the firmware interface.
> >
> > With these changes, the driver behaves consistently across DT and ACPI
> > platforms and ensures correct hardware initialization.
> >
> > Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor clock
> > helper")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Serin Yeh <serin.yeh@intel.com>
> > ---
> >  drivers/media/i2c/ov8856.c | 29 ++++++++++-------------------
> >  1 file changed, 10 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> > index 8bedb47cd7cf..9d2b0469a576 100644
> > --- a/drivers/media/i2c/ov8856.c
> > +++ b/drivers/media/i2c/ov8856.c
> > @@ -2082,9 +2082,6 @@ static int ov8856_power_on(struct device *dev)
> >             struct ov8856 *ov8856 =3D to_ov8856(sd);
> >             int ret;
> >
> > -           if (is_acpi_node(dev_fwnode(dev)))
> > -                           return 0;
> > -
> >             ret =3D clk_prepare_enable(ov8856->xvclk);
> >             if (ret < 0) {
> >                             dev_err(dev, "failed to enable xvclk\n"); @=
@ -2120,9 +2117,6 @@
> > static int ov8856_power_off(struct device *dev)
> >             struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
> >             struct ov8856 *ov8856 =3D to_ov8856(sd);
> >
> > -           if (is_acpi_node(dev_fwnode(dev)))
> > -                           return 0;
> > -
> >             gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
> >             regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
> >                                                    ov8856->supplies);
> > @@ -2293,21 +2287,18 @@ static int ov8856_get_hwcfg(struct ov8856 *ov88=
56)
> >                             dev_warn(dev, "external clock rate %u is un=
supported",
> >                                              xvclk_rate);
> >
> > -           if (!is_acpi_node(fwnode)) {
> > -                           ov8856->reset_gpio =3D devm_gpiod_get_optio=
nal(dev, "reset",
> > -                                                                      =
                                          GPIOD_OUT_LOW);
> > -                           if (IS_ERR(ov8856->reset_gpio))
> > -                                           return PTR_ERR(ov8856->rese=
t_gpio);
> > +          ov8856->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> > +                                                                      =
                         GPIOD_OUT_LOW);
> > +          if (IS_ERR(ov8856->reset_gpio))
> > +                          return PTR_ERR(ov8856->reset_gpio);
> >
> > -                           for (i =3D 0; i < ARRAY_SIZE(ov8856_supply_=
names); i++)
> > -                                           ov8856->supplies[i].supply =
=3D ov8856_supply_names[i];
> > +          for (i =3D 0; i < ARRAY_SIZE(ov8856_supply_names); i++)
> > +                          ov8856->supplies[i].supply =3D ov8856_supply=
_names[i];
> >
> > -                           ret =3D devm_regulator_bulk_get(dev,
> > -                                                                      =
           ARRAY_SIZE(ov8856_supply_names),
> > -                                                                      =
           ov8856->supplies);
> > -                           if (ret)
> > -                                           return ret;
> > -           }
> > +          ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ov8856_suppl=
y_names),
> > +                                                                ov8856=
->supplies);
>
> Can you fix this (multiple devm_regulator_bulk_get() should never have be=
en
> done) first in a separate patch, as Bryan suggested?
After discussing this with you, I believe the devm_regulator_bulk_get() log=
ic is clear. The devm_regulator_bulk_get() is currently guarded by the is_a=
cpi_node() conditional branch rather than being placed inside a loop.
I'll address Bryan's suggestion and modify the commit log in v4.

Thanks.

Regards,
Serin Yeh
