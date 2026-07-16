Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DE2D0606;
	Thu, 16 Jul 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210395; cv=fail; b=btWSd9c0dS1EFucJ+T465YFKP8UvUkAy5VeSYcqtwGbDiTd2CCGj4PFnAtkOa23ekX/KhapQ9omYOc/NVBUAhmiV7tlOHkCDcvvxb0DiHXEWnP9nAZL71IGkPq48TKyfDGKd6na41fyybObdnOHkEgGoqaUWdryJoZCbSOqKJzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210395; c=relaxed/simple;
	bh=af1YGCexfz4YN6GLod2Y5g8h/mHmm+fMe/maW9YXq4s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hwcq7olvxWl80fWgegKAE5adJsZ1NRJ70gOPBFUaIqQvPdxsi3Oih5+4CYwWpAaDUA/L4vnL4npEEzLWaiqJ3QxuauaAoJJqZM02zrL0yIlcsQbLRuxvnbCojVsYUdZuQ1zRrxTNErDsE6ddCwM3GMOgFLYj6zIHESB6WIUjRGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxfMhPwA; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxfMhPwA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784210393; x=1815746393;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=af1YGCexfz4YN6GLod2Y5g8h/mHmm+fMe/maW9YXq4s=;
  b=bxfMhPwAAib9B3ovkUWx43wsj8aXsohd9pRV4k5Qg2KllM4mISYsZpxV
   auwo8Y+i23mFbp8n68kZoFHbioihIeYHVfLBXIhIdxOdhUgjQ1yCvjomP
   PZKJfgLJT1VZ9mPbOxkf7G/niXzHizCQw9m0CVWsdVvbee5eMzCbbR8xQ
   Pudd2pDH/bDB53fIdSuhwsopJMQ6AEDIxvCfQh6wrDmeP0rjIcIJ3Kk69
   rilKKvvJP9BeTq3IiTSk4XRJJqKpVsPZSxzdvKsAWl34XSUWBKnlOg6SD
   7HHPjIoc/1TQJKPForK/+OBChhtK2zYN6jNzsEcCDzjLhoO5+Eo2KrpxP
   A==;
X-CSE-ConnectionGUID: xeV+RqB9R5epxD6Qn+skdQ==
X-CSE-MsgGUID: zT7NpxXoSgqS081n8tEjfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83853335"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="83853335"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 06:59:52 -0700
X-CSE-ConnectionGUID: A7GOxYW7QGaKTzcX/EiiwA==
X-CSE-MsgGUID: RcVdSf1PSxWdAeTB+904Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="253095274"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 06:59:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:59:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 06:59:51 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEc1vTNRuR5rBjuS5l7e87tX+/6Vmbc3oVeP5Wi7OaFxB4R1kGhjZYHqv/nafYQszBTb5fMmd+bvpBARD59TAtbvy23r/Arc0pHduYcTEhod4F2cFbAmt860uWQqrSmnc3J+7asktqXvwQYxDC6q0S0+jrM+HbZAvwO181nPUAuY9ge3hLglyAloepJOC6+qbdlJz8sdWYCVZW/cTdgxkx+qHJDJg3jBPMjiypLEInmVoN3uuHQ3/C3xT5PiTsyhGS60YDUevnSaC3hACpb+qTVu8aagcjOEJLII06f+wHKEa4ELK4QTNLG5ofxMrG9+Dvo4uZAMd1+yBwmLqSn6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRji27vq20RtUwCoZWf+07pYtFoTxPKp2bntzGSrusI=;
 b=H5LSxzaOhVV8S/0Jvh37LCwYL9BYnhbT1WcFWyAr/0E6ymSDWnmnGjUckmqpeBkzyUBn/SQc2KukMVGDSPetaHZWrenxNrlp4yFYblIkN0o/nTyUhj1eBEQR+SM5wuNr9THXRka/89O43YNPEoviyP/1nt9EAc2xtuZ7oM5LD8MKiHf2mLRs6q9V2B87VM3/HqaZQNMeGosPV+TdooWLDp3QIaJUCijua1orvhW8i4znIfwtljYsNF/2Ehj49XkrFLIfNQyBF+YZhULJMbUkoLua17GZ2pXLvqm5Yu6s35OuIJtKes24HktRIQtH61aXKhdETIyA13qVOQK/WnhR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by SJ0PR11MB4862.namprd11.prod.outlook.com (2603:10b6:a03:2de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 13:59:47 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 13:59:46 +0000
Message-ID: <47fa61c2-de68-4ec7-9edd-8f7d5f360834@intel.com>
Date: Thu, 16 Jul 2026 19:29:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION: [PATCH] usb: typec: ucsi: Fix race condition and
 ordering in port unregistration
To: Andrei Kuchynski <akuchynski@chromium.org>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jameson Thies
	<jthies@google.com>, Benson Leung <bleung@chromium.org>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Abhishek Pandit-Subedi
	<abhishekpandit@chromium.org>, Pooja Katiyar <pooja.katiyar@intel.com>,
	"Johan Hovold" <johan@kernel.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>,
	"Myrrh Periwinkle" <myrrhperiwinkle@qtmlabs.xyz>, Linyu Yuan
	<quic_linyyuan@quicinc.com>, Jack Pham <quic_jackp@quicinc.com>,
	<stable@vger.kernel.org>
References: <20260707141736.1635698-1-akuchynski@chromium.org>
 <22064276-6c56-411a-9f20-6917ceeb865f@intel.com>
 <CAMMMRMduSMniMrixGuq=m=00nUvzXQpySE86TpmvfNQtAChB=w@mail.gmail.com>
 <868cab1f-f581-4a01-a9ea-b2fa1a7a2831@intel.com>
 <CAMMMRMdZciCCmfOv0_PhX_VfPtXdMEwNe-CXOLWRSmFYBAEL7Q@mail.gmail.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <CAMMMRMdZciCCmfOv0_PhX_VfPtXdMEwNe-CXOLWRSmFYBAEL7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0339.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::11) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|SJ0PR11MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: b40fd654-2a2e-411f-5850-08dee3427ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|4143699003|11063799006|18002099003|22082099003|15056099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: RgJO7QWm7l988fECDG6TY2BOyb3ndf19jO06DQOO1CbW0r9S2sRgAfTryoP9FOBfvDMNUmkeGEa0bPnHZ58AKm/aeImUhykwX57KA4HxlBDKIdPseNYOYFXaeVejmbnJyCH/+uVzC8uG+TkZNFOuUuWDfAVoy550za4MdKMr//YAWgAHQw3AEU9OsnQGzGsxbw+CsnIPSzMfIQTbA5o8KKT/QK/mAjKiotItCzKbDv9gZPdYuGQ619nmwdwe+gVju/+dxnbTaaf5w6zwwlBxAKJ4hjF0mlspwE5yhFpKFnokwKPgD5zoMlMQ4F0pPfVoUdHmobNVNPTrkrvzM/jbztwAVtmnvqIqqB3TLw6Y9Z7+wrKApi36KViL+ZVuTwr56nzKCbPsoXOuqKgS24jI2UNR1yJQr4F0kGHFS+xkLKo1TtumGz9OECXtgOEXETD8w2ivJeMbNa6Pyqq47kYLffkbTzX2FrEa4QHCWMydYQthMDS5/QsAfbOqyDS/aLYrIofWctYsWCKU2GrdI6uq7TD+fgiWeu0obrrXq52nw2xVmOBLGQMar7KYadcGeoayb5znDfudrU1mQs7YEea1bPkEL1E4vNbrzak+1mGCP2U1SyFV4Xk/Tm8QP/66OBza
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(15056099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkdwNUtVdU1Yc0JpNG1pTFpodWhDZVZQT0hJK05wSHRZYVgycHFKeVdSTjl5?=
 =?utf-8?B?WEUxYjhYamRRNUVGR2VLckUyTTBwcnVHdkFiU25Wcm1TUXVnRDM0Vm0yc1lK?=
 =?utf-8?B?UVpwSDZleUs2WHpjMW4vNUg1TkxVMWl6dFZNaWV3NDd1L1VILzVkR1NMR3Q0?=
 =?utf-8?B?Yk82RjFxWnkwS0lpS3o5NDVuRkVjQ1RZekkycjdraXlYVnlZTlBiRCtwanhS?=
 =?utf-8?B?Mmoza2hMOWlOQWpEVlF6Z213aitYRTZlTjEzeDBrTE9PbllvQXVYa0F6MXZm?=
 =?utf-8?B?UVBMQkpZVTJlRWhPU3VFQmI1MVdRMHdwdFFGbTUwRHB6dlpSZGpDbzROVlF1?=
 =?utf-8?B?UWY5RENOZHZYMWNCaHVrdVVobTFrSG9KbkkwVTNHYituUlFLZlpsdFp3bEIy?=
 =?utf-8?B?WHFGY2pZamY2K050QW9NSlJCWURacE53cHJnT0VMRHpydzZOVXh2bkRYU2pQ?=
 =?utf-8?B?UjFEM2dOTnJjWUdLby9hd0lBb01acko4Y1J6MW1JdjBSUFUyNW40UnpNMHhH?=
 =?utf-8?B?QTR1S0VTM2VnckdUQ3hzOGIwZUQzS2gzUmJSa1oyMDMvSkFkQ041YWQvMXdk?=
 =?utf-8?B?UHRURmtyTUxjRWdCTiszdVFiblg3QnU3ZmlVTWlVS2FJUThhRTVnOHlLSGVh?=
 =?utf-8?B?OURMeHdGMTVlb0RUa05mNmZQOE1xYllxeTZoeDVjRDJNamdJekhQRm10M2ds?=
 =?utf-8?B?M0hCRWNwRytmV0JyNEtMeEVjd3BCUlpJaHp5ZUFsanRWR1ZXVlFzV29xeHRm?=
 =?utf-8?B?a3pZWEhhMmRTbFgwVGVyNk44VEQyY2dxbVowY21kY3NIK25TanpHZzArSTdz?=
 =?utf-8?B?Zlg1d2kwcEdpMHlvWmpaRFBoTFppUXBVYmRmTyt5cm1XcWxvRC82Z0ZZaEZO?=
 =?utf-8?B?YzhyMGJYaTdONWxsTGFLYmV2ZWc3cittQTRLV04yVVorYVE4ZlE2WElHTFZL?=
 =?utf-8?B?VU1RWExtanFwZU9aWVFQZ1E3dUpHTTdwY25PMkgyZkxUQnhycC9ZUG1qTk5O?=
 =?utf-8?B?R1hIOFZEK3JQK0FwTXNwMFNWbzI1YkpmWVorcDk0V1FKSlhYUmJEWVBhNkpH?=
 =?utf-8?B?VXU0ZzF0WGpSeG81NXE2TmpWZGNJQVZmRTNGQWdBcFdUdU5FanhwY2dSemZr?=
 =?utf-8?B?NmxWY2NTWncxQmRNRWE4UGlxV1dDbGQvRStBbVJHV1RHaC9kZkZiSWgwRDN0?=
 =?utf-8?B?ZkJKdHFQS2JOYVVCdlVWN1B3N29kM2JEV283amlwY1RPOFhSNkVLcnQrcW5H?=
 =?utf-8?B?VFNvY2VWQzRObWN0ejNta0tjQWVPdlpSdmovRW1xR0NHd1ZEQjk2MUVsZkUy?=
 =?utf-8?B?RTU2UFVXUzRpWFhtTGdhMmoxL1NjaWdTWnA3UWRTbHB2czNxV0c5M3duVDZy?=
 =?utf-8?B?MnFKMmF5K0JtRFBXQm1XV080aFczU2VMTkVnUVV1UytPZ1BkNHE0MFptRi9k?=
 =?utf-8?B?ZkcyTE9CUkNuNlR6UmdueURrSFE5aERhZWkzOS9MSEplZ1AzSFczTXRMeXkv?=
 =?utf-8?B?VnJTNzUvNkdvNVlyOWtQS29QaGlTMTdKR29Hekg3aHd4NmhFZkVPNWsxQ29k?=
 =?utf-8?B?RFdzUDdBdXRydmg2VDBLV1E1eStXa2h3Rm5acUVoZmZJVTZTNHlleWp0cUxI?=
 =?utf-8?B?amRFUE5lRkV3V0FBbk5EVnF1Ni81Y1hwa0c2SjBCL29iWU4zL29QL04ybUgy?=
 =?utf-8?B?RDZIbmtpVWdsbUE4Wkh6LzhrekpSNUhBK2ZHVTNaWnJYY1NVTzNxdWVsR1ho?=
 =?utf-8?B?ZHBadGpJNXN6cFV5RVV6c0x5TkFURTZyU3VhNitGa1VGbXFQcFJsODlzZmgx?=
 =?utf-8?B?Q3kxWEJpOVNiSTF0MVU0Vm0rNmhKQURVZVQzaDllRElwYW1YczZHYjNKdmtL?=
 =?utf-8?B?MTFNb2F0VFJ0Wll1Tk5NL1pyMmhyR0tHNlpPMklDcnY1bmtLb3dleitzTHFO?=
 =?utf-8?B?QUFJMUY1bytobnVtSVFnNHJoakFQTjF6M3pQMFpjaXFDOHQ1YnJJYWFhOEFp?=
 =?utf-8?B?YklkcjBrdERId3VSSnZyUlNDU1BaYlA1VU5zUDFmQ1ByaXlONmYxS256TkVr?=
 =?utf-8?B?NUJUK2NFMC9SYlBKdHJRWW5XZG15L21CZzAwa0RqVkFMbU5WSlJxMlpKOU9t?=
 =?utf-8?B?ZDk2TUFULzhHSDVnWjVGM0tjN0FTdVluNWQ0bTNBSTFWTHdhNFJFOXNkeEpY?=
 =?utf-8?B?djNaem51cHp1dmJGell6ZlNUN0diZzZEL0tNMDVRU0QrYWdneHN4Y3FuSTEw?=
 =?utf-8?B?NTZSZUF3dmIrOVVjYm40RGZFcGlVdkI1bVhzTzRCV29MYTFSN2ZzSllPdWs5?=
 =?utf-8?B?WTNveTQwbCtjNDlYdW15VUNqVWhMVTlkWWNGdDlMNUJYY1Z5dVJRdmxMVDRw?=
 =?utf-8?Q?HkUFD5xm7J3RMZiY=3D?=
X-Exchange-RoutingPolicyChecked: I22xVqn/lsW+K+fuFfYEEunDU/SN0C6g2WYuoDGWBwlgqAhENMTI/e/i/+s+y1FpRLCE7Of6GZTcsFlsp2wUHfrdlHkLCmO3ECdE/jHZlJIJNBjVdzz3kFgFmxb7t+b97rcjZvi3pSQc5g2rix3keyOXt8VB3C23h3zoqPDm45l8JPM2TqJde9BbhBqLYdKW1TWvY/H8/MBE5PmetUKzCrGyM2F3uQ94+HYgkYa9wd84mMfDmunmru6RyHOcPsz2PYg223XSWQofPtTiAxMJPIgNdy2nSJT/LzHqoImML9ZtVPtuPhhI8pZAWxReruD6PrumYbVrLMjNNE/ftEr9Ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: b40fd654-2a2e-411f-5850-08dee3427ea9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:59:46.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9pjUcXcqp9B9mi4tNxE0seWB4InBbXguVtYDxdRP2WZ7rXQec4lOqpj0FhaJRY5PY3Uu/CVjvXKprx5humbkL4l5whtR3SftxUfZFHBu7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4862
X-OriginatorOrg: intel.com



On 7/16/2026 7:11 PM, Andrei Kuchynski wrote:
> On Thu, Jul 16, 2026 at 3:23 PM Borah, Chaitanya Kumar
> <chaitanya.kumar.borah@intel.com> wrote:
>>
>>
>>
>> On 7/16/2026 2:45 PM, Andrei Kuchynski wrote:
>>> On Thu, Jul 16, 2026 at 10:28 AM Borah, Chaitanya Kumar
>>> <chaitanya.kumar.borah@intel.com> wrote:
>>>>
>>>> Hello Andrei,
>>>>
>>>> On 7/7/2026 7:47 PM, Andrei Kuchynski wrote:
>>>>> A synchronization issue exists during port unregistration where pending
>>>>> partner work items can race against workqueue destruction, leading to
>>>>> use-after-free conditions:
>>>>>
>>>>>      cros_ec_ucsi cros_ec_ucsi.3.auto: error -ETIMEDOUT: PPM init failed
>>>>>      BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>>      RIP: 0010:__queue_work+0x83/0x4a0
>>>>>      Call Trace:
>>>>>        <IRQ>
>>>>>        __cfi_delayed_work_timer_fn+0x10/0x10
>>>>>        run_timer_softirq+0x3b6/0xbd0
>>>>>        sched_clock_cpu+0xc/0x110
>>>>>        irq_exit_rcu+0x18d/0x330
>>>>>        fred_sysvec_apic_timer_interrupt+0x5e/0x80
>>>>>
>>>>> Fix this by ensuring strict ordering and proper serialization during
>>>>> teardown:
>>>>>
>>>>> 1. Move ucsi_unregister_partner() to the beginning of the teardown
>>>>> sequence and protect it under the connector mutex lock.
>>>>> 2. Ensure all pending partner tasks are explicitly flushed and finished
>>>>> before the workqueue is destroyed.
>>>>> 3. Switch from mod_delayed_work() to a cancel_delayed_work() and
>>>>> queue_delayed_work() sequence. This guarantees that items currently marked
>>>>> as pending won't be scheduled an additional time, preventing a double
>>>>> release of resources which leads to the following crash:
>>>>>
>>>>>      Oops: general protection fault, probably for non-canonical address
>>>>>        0xdead000000000122: 0000 [#1] SMP NOPTI
>>>>>      Workqueue: cros_ec_ucsi.3.auto-con2 ucsi_poll_worker
>>>>>      RIP: 0010:ucsi_poll_worker+0x65/0x1e0
>>>>>      Call Trace:
>>>>>      <TASK>
>>>>>        process_scheduled_works+0x218/0x6d0
>>>>>        worker_thread+0x188/0x3f0
>>>>>        __cfi_worker_thread+0x10/0x10
>>>>>        kthread+0x226/0x2a0
>>>>>
>>>>> To ensure these rules are applied identically across both the normal
>>>>> teardown and the ucsi_init() error paths, consolidate the cleanup logic
>>>>> into a new helper, ucsi_unregister_port().
>>>>
>>>>
>>>> This seems to be causing regression in our linux-next CI. [1]
>>>>
>>>> <6>[   18.008557] ------------[ cut here ]------------
>>>> <4>[   18.013166] DEBUG_LOCKS_WARN_ON(1)
>>>> <4>[   18.013167] WARNING: kernel/locking/lockdep.c:238 at
>>>> __lock_acquire+0xa59/0x2750, CPU#1: kworker/u89:1/172
>>>> ...
>>>> <4>[   18.159950] Hardware name: Intel Corporation Meteor Lake Client
>>>> Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS
>>>> MTLPFWI1.R00.3471.D89.2401091901 01/09/2024
>>>> <4>[   18.173125] Workqueue: events_dfl_long ucsi_init_work [typec_ucsi]
>>>> <4>[   18.179257] RIP: 0010:__lock_acquire+0xa60/0x2750
>>>> <4>[   18.183927] Code: 44 8b 5d a8 85 c0 0f 84 98 fd ff ff 44 8b 35 07
>>>> 0b 72 02 45 85 f6 0f 85 88 fd ff ff 48 8d 3d 27 25 73 02 48 c7 c6 1b 51
>>>> 27 83 <67> 48 0f b9 3a 31 c0 44 8b 5d a8 44 8b 4d b0 e9 c6 f7 ff ff 31 d2
>>>> ...
>>>> <4>[   18.263886] PKRU: 55555554
>>>> <4>[   18.266583] Call Trace:
>>>> <4>[   18.269014]  <TASK>
>>>> <4>[   18.271110]  ? mark_held_locks+0x46/0x90
>>>> <4>[   18.275007]  lock_acquire+0xd9/0x2e0
>>>> <4>[   18.278562]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
>>>> <4>[   18.284096]  __mutex_lock+0xb2/0x1020
>>>> <4>[   18.287735]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
>>>> <4>[   18.293265]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
>>>> <4>[   18.298797]  ? synchronize_rcu_expedited+0x2b2/0x300
>>>> <4>[   18.303724]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>> <4>[   18.308912]  mutex_lock_nested+0x1b/0x30
>>>> <4>[   18.312806]  ? mutex_lock_nested+0x1b/0x30
>>>> <4>[   18.316878]  ucsi_unregister_port+0x36/0x140 [typec_ucsi]
>>>> <4>[   18.322238]  ucsi_init_work+0x66d/0xc10 [typec_ucsi]
>>>> <4>[   18.327167]  process_one_work+0x2ad/0x8b0
>>>> <4>[   18.331158]  worker_thread+0x200/0x3f0
>>>> <4>[   18.334886]  ? __pfx_worker_thread+0x10/0x10
>>>> <4>[   18.339128]  kthread+0x10d/0x150
>>>> <4>[   18.342339]  ? __pfx_kthread+0x10/0x10
>>>> <4>[   18.346067]  ret_from_fork+0x3bd/0x470
>>>> <4>[   18.349795]  ? __pfx_kthread+0x10/0x10
>>>> <4>[   18.353522]  ret_from_fork_asm+0x1a/0x30
>>>> <4>[   18.357420]  </TASK>
>>>>
>>>> Detailed log can be seen found in [2]
>>>>
>>>> We confirmed that reverting the patch solves the issue.
>>>>
>>>> Could you please check why the patch causes this regression and provide
>>>> a fix if necessary?
>>>>
>>>> Regards
>>>> Chaitanya
>>>>
>>>> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
>>>> [2]
>>>> https://intel-gfx-ci.01.org/tree/linux-next/next-20260714/bat-mtlp-9/boot0.txt
>>>>
>>>> -- Bisect Logs --
>>>>
>>>> git bisect start
>>>> # status: waiting for both good and bad commits
>>>> # good: [5f1b513690edf51727e6928b97705b6437f9a98e] Merge remote-tracking
>>>> branch 'spi/for-7.3' into spi-next
>>>> git bisect good 5f1b513690edf51727e6928b97705b6437f9a98e
>>>> # status: waiting for bad commit, 1 good commit known
>>>> # bad: [49362394dad7df66c274c867a271394c10ca2bb8] Add linux-next
>>>> specific files for 20260713
>>>> git bisect bad 49362394dad7df66c274c867a271394c10ca2bb8
>>>> # bad: [dffddeb046466ed57038295bde28b42b7506a12b] Merge branch
>>>> 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
>>>> git bisect bad dffddeb046466ed57038295bde28b42b7506a12b
>>>> # bad: [d154d0766bf3fe830e1bf98fb2d8648294a4a8da] Merge branch
>>>> 'for-next' of
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
>>>> git bisect bad d154d0766bf3fe830e1bf98fb2d8648294a4a8da
>>>> # bad: [671b0fd929bec9ebf863cb376baf9b9d1226a510] Merge branch 'master'
>>>> of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>>>> git bisect bad 671b0fd929bec9ebf863cb376baf9b9d1226a510
>>>> # good: [f4fb100039e96211609dfc44fb24b9e4a8a0f2f9] Merge tag
>>>> 's390-7.2-4' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>>>> git bisect good f4fb100039e96211609dfc44fb24b9e4a8a0f2f9
>>>> # good: [c296d513e034df93ddb230ad1c7a118d6b58750c] Merge branch
>>>> 'arm/fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
>>>> git bisect good c296d513e034df93ddb230ad1c7a118d6b58750c
>>>> # good: [de53c0a584f08f31eb957f8c849a59fb33b27fa8] Merge branch 'for-rc'
>>>> of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
>>>> git bisect good de53c0a584f08f31eb957f8c849a59fb33b27fa8
>>>> # bad: [a6969de5a038bc08a948ada52bd7199a8dfa6cec] Merge branch
>>>> 'usb-linus' of
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
>>>> git bisect bad a6969de5a038bc08a948ada52bd7199a8dfa6cec
>>>> # good: [15eab2dd63a97587405ab6bfaad9728d5b35b5fe] Merge tag
>>>> 'asoc-fix-v7.2-rc2' of
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
>>>> git bisect good 15eab2dd63a97587405ab6bfaad9728d5b35b5fe
>>>> # bad: [c2e819be6a5c7f34344926b4bd7e3dfca58cf48a] usb: gadget: printer:
>>>> fix infinite loop in printer_read()
>>>> git bisect bad c2e819be6a5c7f34344926b4bd7e3dfca58cf48a
>>>> # good: [29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b] USB: gadget:
>>>> snps-udc: fix device name leak on probe failure
>>>> git bisect good 29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b
>>>> # good: [1febec7e47cdcd01f43fb0211094e3010474666e] usb: gadget: f_ncm:
>>>> validate datagram bounds in ncm_unwrap_ntb()
>>>> git bisect good 1febec7e47cdcd01f43fb0211094e3010474666e
>>>> # bad: [0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb] usb: gadget: udc: bdc:
>>>> free IRQ and drain func_wake_notify before teardown
>>>> git bisect bad 0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb
>>>> # bad: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb: typec: ucsi: Fix
>>>> race condition and ordering in port unregistration
>>>> git bisect bad 7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261
>>>> # first bad commit: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb:
>>>> typec: ucsi: Fix race condition and ordering in port unregistration
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
>>>>> Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
>>>>> Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are flushed")
>>>>> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
>>>>> ---
>>>>>     drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++------------------
>>>>>     1 file changed, 39 insertions(+), 43 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>>>>> index 92166a3725b16..d9668ed7c80ea 100644
>>>>> --- a/drivers/usb/typec/ucsi/ucsi.c
>>>>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>>>>> @@ -1845,6 +1845,42 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>>>>>         return ret;
>>>>>     }
>>>>>
>>>>> +static void ucsi_unregister_port(struct ucsi_connector *con)
>>>>> +{
>>>>> +     struct ucsi_work *uwork;
>>>>> +
>>>>> +     if (con->wq) {
>>>>> +             mutex_lock(&con->lock);
>>>>> +             ucsi_unregister_partner(con);
>>>>> +             /*
>>>>> +              * queue delayed items immediately so they can execute
>>>>> +              * and free themselves before the wq is destroyed
>>>>> +              */
>>>>> +             list_for_each_entry(uwork, &con->partner_tasks, node) {
>>>>> +                     if (cancel_delayed_work(&uwork->work))
>>>>> +                             queue_delayed_work(con->wq, &uwork->work, 0);
>>>>> +             }
>>>>> +             mutex_unlock(&con->lock);
>>>>> +
>>>>> +             destroy_workqueue(con->wq);
>>>>> +             con->wq = NULL;
>>>>> +     } else {
>>>>> +             ucsi_unregister_partner(con);
>>>>> +     }
>>>>> +
>>>>> +     ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>>>>> +     ucsi_unregister_port_psy(con);
>>>>> +
>>>>> +     usb_power_delivery_unregister_capabilities(con->port_sink_caps);
>>>>> +     con->port_sink_caps = NULL;
>>>>> +     usb_power_delivery_unregister_capabilities(con->port_source_caps);
>>>>> +     con->port_source_caps = NULL;
>>>>> +     usb_power_delivery_unregister(con->pd);
>>>>> +     con->pd = NULL;
>>>>> +     typec_unregister_port(con->port);
>>>>> +     con->port = NULL;
>>>>> +}
>>>>> +
>>>>>     static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
>>>>>     {
>>>>>         u16 features = ucsi->cap.features;
>>>>> @@ -1971,22 +2007,8 @@ static int ucsi_init(struct ucsi *ucsi)
>>>>>         for (i = 0; i < ucsi->cap.num_connectors; i++)
>>>>>                 lockdep_unregister_key(&connector[i].lock_key);
>>>>>
>>>>> -     for (con = connector; con->port; con++) {
>>>>> -             if (con->wq)
>>>>> -                     destroy_workqueue(con->wq);
>>>>> -             ucsi_unregister_partner(con);
>>>>> -             ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>>>>> -             ucsi_unregister_port_psy(con);
>>>>> -
>>>>> -             usb_power_delivery_unregister_capabilities(con->port_sink_caps);
>>>>> -             con->port_sink_caps = NULL;
>>>>> -             usb_power_delivery_unregister_capabilities(con->port_source_caps);
>>>>> -             con->port_source_caps = NULL;
>>>>> -             usb_power_delivery_unregister(con->pd);
>>>>> -             con->pd = NULL;
>>>>> -             typec_unregister_port(con->port);
>>>>> -             con->port = NULL;
>>>>> -     }
>>>>> +     for (con = connector; con->port; con++)
>>>>> +             ucsi_unregister_port(con);
>>>
>>> Hi Chaitanya,
>>> Thank you for spotting this!
>>>
>>> Could you verify if calling lockdep_unregister_key(&connector[i].lock_key)
>>> after ucsi_unregister_port(con) resolves the issue?
>>>
>>>        for (con = connector; con->port; con++)
>>>               ucsi_unregister_port(con);
>>>        for (i = 0; i < ucsi->cap.num_connectors; i++)
>>>                  lockdep_unregister_key(&connector[i].lock_key);
>>>
>>> I will also try testing this on my side.
>>
>> Thank you Andrei for the patch. It seems to work for us.
>>
> 
> Hi Chaitanya,
> 
> Thanks for the testing!
> I will prepare a fix or maybe V2 of this patch.
> 
> Could you please share your configuration details? Specifically, do you
> have any of the following enabled?
> CONFIG_DEBUG_LOCKDEP
> CONFIG_LOCK_STAT
> CONFIG_LOCKDEP_SMALL
> CONFIG_DEBUG_LOCKDEP
> CONFIG_PROVE_LOCKING
> 
> I am still  not able to reproduce it.

I hope this is accessible.

https://intel-gfx-ci.01.org/tree/linux-next/next-20260713/kconfig.txt

We also see this issue only in one of the CI machines. So it might not 
be the config.

==
Chaitanya

> 
> Thanks,
> Andrei

