Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110C23EA8B;
	Thu, 30 Jul 2026 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395354; cv=fail; b=TRv8AgbpE7waHinIO4AUgX4EdVHoSrGqHf73n2V0oNCsY6aLrplr8U/sw1kerQTYnYmWorvFGXorcrmLBTnyghSrWgFW1KzDigd8V9aUKjagusiVcHT1j2RHSclRYfuYKvfeWW/tzcdt442j85/Nfq/jqq6UwF/jqw+6cFZheyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395354; c=relaxed/simple;
	bh=0vfyMandeKHFWayMvVqGyw/kLFZg1wV6YzrSwxwUbEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZ8h7mpgu8u0YxR6LwQAX6uvb/fXc+ng1cIkSOot6cp+J+s/TRldMH9Ia/kSZ2QFq90A/nae44UCtnivZFrWHL29ulMBcW57rkuPEH5FNjtL/sBcTel2mrgHARj/9Z4G+Yuw4oXdxbitL4kmxc25zB6NLSZEVitVY6dNp7gzPPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzCNQAyJ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzCNQAyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785395351; x=1816931351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0vfyMandeKHFWayMvVqGyw/kLFZg1wV6YzrSwxwUbEY=;
  b=bzCNQAyJwVkd1s2PbTFjtQZw4LgD0doMdAZpxKmpoaTv1y18srJ/c5rw
   YGZ7twj7EOPk6biV8YoLIFUAZo9F4k+dS5jokPQnZkZOGFebWMtkr0muo
   Wd5I+zqcAILIU8CpWYA5vPzLRKNZdIhjcqq0MR+dtU+/zeuRTa4NUqrsH
   WcBsq9Faqyyf+TxJZHEpWN6VwIaypUukcGbQ21FL3lULU5lkyJOiTG1pl
   MH6gVYhw2r9aNfFfLTOZZQNo4YVHdjcFJPJHTHhqXfyEyEwT3wTTZGRlT
   4rlLehc9QrFSEhOAkuDCSVWXTZjsSCulJZYcnpA7+MsnUlQTnU1A/EJSo
   g==;
X-CSE-ConnectionGUID: /GsWgUN8RiO1ChFgiGm/Zw==
X-CSE-MsgGUID: vdBnp0lJRa+zQy7SWRd7ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85957507"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="85957507"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 00:09:11 -0700
X-CSE-ConnectionGUID: WHvmay4iSfS1ayriWc7XqQ==
X-CSE-MsgGUID: NLqqOiv2Q8Wp2s5M+56uDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="256888297"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 00:09:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:09:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 00:09:10 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFzRdjOn/QNGW8Ap0eSU6UrO+iBwnYMDfENrY94rE42dX1Ghe5Nl7xYbYs14sicaFHnDK2R46RSKN1pIl38zbrZ3PIBR46apPGci17rhYHUXlD8xYuMO++90AQXi1hToOp1MDLxl2pdlEVaPmOrqC5U21w5h17NMD/yvhj6LVw5b+7qMFXebtxS2twD2E1rmwbpYIcR8cL5pYWEM8+q/NFTiB7u8ohTWdzoyAp2lOZWw7EWvoPhVejo2MR4CQtE03kyQ8WecF/Ut45eQZsWVHK9RYIbuSPIxiFCZgzIofw9W1TsLnXvx2kwOzI72kHpPbZI0chA1SxgwJeppMVVhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmKJpQtAdCj8jmxN+mkLxy+1P861QKWgqQGlGWoz+jo=;
 b=Z4J0hPZ9q3ITngZhbkVX/sPRy+XtZKbAmcOKgQq70NqmMYgqIDRJECAThGcActKI6sTTRJaK4nvYoPDhp7KgRl4KNB+OZe8IYaWDBupFJHDsF97W3NUySpIGz6dR9ZYpgnzXFMCqhn9B/8Cq29dZS+W64p9A2mnNCNIHqqfj595HiFQQwYiBQdFhCWsY0Q80wcHqHY7rcOCTgeQPf0wgzh1dNp0RZx1ZlxmrKQk9R2gwuX8Nwj3MAm2tscNy7UxzyH1VE1XncaTMeQShyDedNJR87IMMbnggCqyMoX2hS0uBR6SJq+Sv7u5KL1HIE9BqJYyPV1nCdxRNPwuPNRHyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by PH8PR11MB9608.namprd11.prod.outlook.com (2603:10b6:510:3a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 07:09:08 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 07:09:08 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>, "Jose Ignacio Tornos
 Martinez" <jtornosm@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "horms@kernel.org" <horms@kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v7 3/4] iavf: send MAC change
 request synchronously
Thread-Topic: [Intel-wired-lan] [PATCH net v7 3/4] iavf: send MAC change
 request synchronously
Thread-Index: AQHdAvmzI/Q1v3IoYU+HelIop6H9iLZQ9CqAgDTqX5A=
Date: Thu, 30 Jul 2026 07:09:08 +0000
Message-ID: <IA3PR11MB8985BA1965D4B4115709F0228FC92@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260623101800.991293-1-jtornosm@redhat.com>
 <20260623101800.991293-4-jtornosm@redhat.com>
 <PH7PR11MB5983BDCC3B90AD13F2778847F3EB2@PH7PR11MB5983.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB5983BDCC3B90AD13F2778847F3EB2@PH7PR11MB5983.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|PH8PR11MB9608:EE_
x-ms-office365-filtering-correlation-id: ec81d8f3-9d06-4d08-8273-08deee0972f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0C8LoHMvFhYZgWodAzyzYVBpXybLhv9QTweX3/CFwWfpqhH2XDvz50dCvs5Kd5yFdbzq/qnsLT+iksxijmW6l+kUfcOh0OUXUS8PTALRSRcHXta+8t9lO15VXn+TB++pJAE17DKqU+He/Hg66wTGMatqp4owm8gZJ1bwbPo5xf+knx5Buc0nNd1R4vCf99/yfHpNMTcze7ye42qtMV+2aaVJI6dgJNrWv37mtS5mEmRIFiuTiXer4xXvJdQAbAEHgbtOH67+l4GgerqztwiGUIvK9Vjh3pF1zIlEShHLgTjBm4qw2y2hdNEDemcZ6r+TlHVEIc6wwXfKa54khethcFnqHsOLnKeXIOfNbVyLyCDaQ8z8vEdWoBgi3siTRf1hjnNVSacY4J9leXhEeLH42OkCnwzl94VHCSMHz70fm5EE1veEm2gEI9Vuh1Ljpr5lHK9hgj/UlwISjj1MFK0Mx5mFfKslvUx0JPWlGc/kuYok4bUwMe3PfjGiVfaXEUzZ0EFu0065AldlPS+1sid2GhP4V8He2zp6IAd9AbqXdaMmkFiJuLkA3d2NlBaW/SMqiwdFP+MR2sbj4n+HEAqxJX3RlZ57l+dAsUIoIlRHY3vlbEyHh+wnNkWAQdU4vOrOQMzKhzrkCwsKweVluSve76VOkpJNjlV0kf1ywdNuYjbwB48o3b+G+A8A5yBYPmnneil/pp1GIyJISBGvgOe77yTqItHnR/Ge86Y+EK13Xwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XIRIcemX1GucoJEQEx9wYDbOShNnXKDnD/ARda41Ktd1u+H3pjoBT7sB5k1t?=
 =?us-ascii?Q?IRqo7u6XOZ5OhKgdi4MTwiY6rL9wA7hGWClF4i4hW1/2tybRNasf9nnFBCK4?=
 =?us-ascii?Q?luQvhbhBBIGy+EsEqfdfiGEv5lJBolju73CVkuR3xvQIuU1Hpsc9dh+tFgL+?=
 =?us-ascii?Q?6mRmRwQEI04Gt1S11TKMYAcnqbMzTc61gdX7jA0JnIKxgByme+4AsgJYUnTj?=
 =?us-ascii?Q?HnYdTLkGOShNuyDZdDZ+CACR7WHDlyAGGHu/Eu6LsKYuvC5T+fX4IExbQiwd?=
 =?us-ascii?Q?eMxLKQzqbbHLfws2vRUnhsS1aX18dMAopukuPziihSJHUgGCFwYgBipkelO1?=
 =?us-ascii?Q?cLDDgyAHsB/txQBzmHC0tQYtNThVJW4/AiN9RF+F/NXc4NNGsY+9kBY6xua6?=
 =?us-ascii?Q?xhI1dbCP8q4MSneCMFm1MHqd7jIkimYzCSjRbdin5G1AX7gVzPZs95/FiaII?=
 =?us-ascii?Q?SmvRnSjLku0LZP65yzBnutDG1urRFywUnKa3jFzaCjaO0lethUfsgSMOlKuV?=
 =?us-ascii?Q?PXph54YZVw/+UYZCCrqO0Fr6aPbYSemcLnDg6HDj8SnROQeqUrDVBVbSTjNE?=
 =?us-ascii?Q?eWYeUPTvX/QqiiFmnN2ydjdeTF+iGnBfsCN1KWqAZQqHFEgg1uw0bHSKZH0Z?=
 =?us-ascii?Q?zAdUIVS2XKUPTmsDk/I/s0HQhA/O/yWpv9tRLdQTU0gtG6+eb7SvxboySDs3?=
 =?us-ascii?Q?R/8XWkDSpJGdjDJOxMcAfLMRocyHHiiXnsSwQ+mjuz6MIhz6Eam51jA4lXQN?=
 =?us-ascii?Q?eoB+cwF8DHt2eGlUteprpta1ndxWo6WBuqSBxUF12To8YsHYOy+8WQ2qrpUS?=
 =?us-ascii?Q?pdVWHlcfyEmaG4asGeLO+fLzmrOoR/Zdo/5AE2fJWP/iXwAPtIao7B35KQLB?=
 =?us-ascii?Q?fjgHHPb4Ws1NIrQN6FQ6YIyQKDJgCY2AnOuWOr24VU4PooY3WLitQhO0G6Vt?=
 =?us-ascii?Q?qU0SmT35fh08FKZ7q4YxzOUyObALShthyS42Kw8WMXzqX3PtiB+Ra20zKlUT?=
 =?us-ascii?Q?Xwta/sUSJF634Y2gYMShJtFtTJoq364EHPY8/MnhgIFY28zcU3tf8EhKJQSt?=
 =?us-ascii?Q?+gl+9gqxev/57ocPKe4H22VYhCORBCZI3xFMnMYYzDmuCumhCouNufn0ySZQ?=
 =?us-ascii?Q?bzca/vYVJ3aV5HYOU0L7THCGixfva1bh5wZUEScZyUW9bl6bhmAvb0Jz8xb6?=
 =?us-ascii?Q?XB0WK3zCkhqI8VAPnoQoafah0kE+7nCbiSleoac4v/b2OY/AdS1s9fo6smLf?=
 =?us-ascii?Q?gH2XmD+ABHjIUGvIwn3/aqB1A0DyHv8gUA9Ff98TrqxCscEiK1ByHuqMU+FR?=
 =?us-ascii?Q?m7oHpjjM8MmmGkbI4S0Nj9NEIYJHwscXpjYF/AhlImsSE6F1V7bi3hS7Bfpe?=
 =?us-ascii?Q?OAiNwke3aqSdnm6codaRCs6aiiHwdotNZn0o2pXOMw8cVTM68fI/+A46laNH?=
 =?us-ascii?Q?exgnu2FmSCdYAaWjr8hPQ/9Vx+Ly0jchRjP46Gcr4gliP9oLqOk55OVAQ1qC?=
 =?us-ascii?Q?8arR9t9Z8dFBcrBMazV6lD7Dq42brvcEkCAdfRL1VhTLlFVndct+4gEdig0u?=
 =?us-ascii?Q?ewcg07T1MUmJNcIBkHm6l9wPJQAvcBjUUWKsjDcTBlns1yynV34P/PImJGas?=
 =?us-ascii?Q?rCxr7w+XV2gLvDSKTM71FFdB13Wf3/uS/nYyh+HlV3kXvEouR8Y3pk7BgtLj?=
 =?us-ascii?Q?98gdZa+SG88p6fk63os2pkoSbl78wLFDxwnaepgpFDA4E7uExUHCMNwPS54T?=
 =?us-ascii?Q?JlU8WQZUVQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JnuR6NEwd5DoQ+BjVcRA57dQhZepBe/nRXoL5ZKbjaVBt+PVt3MT/FnU2HZnW5XuZ0ubttUCgUGU8HsQiQs8AT2JjNSGIeIYQfdHApsRVxVrQZNHFxH8qMgOnl7AS6ff5FqF2OTwg2ydcK8ppNX6u0jospTa4GRdkWQM0tUsHum1mHK7NlyOoraGeFC62Q2X0wQjGaLJWq7POeUG5R+aC7r4dWuW18hPlE+wljGtoX7Y+AXyK9ziy2Q2idb6RkiEN60RyEmxvLMFv+dyI7L3N3OchunmAxuoqjv5gnOu3/Gqbe/RJ9x8JiOqZq43vwqWOBuEpeBn0VpvcWgnr3lGQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec81d8f3-9d06-4d08-8273-08deee0972f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 07:09:08.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Of87umpej11bYWuSIQeULk03OorGyHJtrDYa/BrC8blh25wfB0yEFFjOPfrZxp1PEiNsHFyFC45rnY1NDMWvXI6f7Lg1ZD37Ftn+JBd2/5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9608
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Kwapulinski, Piotr
> Sent: Friday, June 26, 2026 5:04 PM
> To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>;
> netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E <jacob.e.keller@intel.co=
m>;
> horms@kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; stable@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH net v7 3/4] iavf: send MAC change r=
equest
> synchronously
>=20
> >-----Original Message-----
> >From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> >Jose Ignacio Tornos Martinez
> >Sent: Tuesday, June 23, 2026 12:18 PM
> >To: netdev@vger.kernel.org
> >Cc: intel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw
> ><przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> ><aleksandr.loktionov@intel.com>; Keller, Jacob E
> ><jacob.e.keller@intel.com>; horms@kernel.org; Nguyen, Anthony L
> ><anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com;
> >kuba@kernel.org; pabeni@redhat.com; Jose Ignacio Tornos Martinez
> ><jtornosm@redhat.com>; stable@vger.kernel.org
> >Subject: [Intel-wired-lan] [PATCH net v7 3/4] iavf: send MAC change
> >request synchronously
> >
> >After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
> operations"), iavf_set_mac() is called with the netdev instance lock alre=
ady held.
> >
> >The function queues a MAC address change request via
> >iavf_replace_primary_mac() and then waits for completion. However, in th=
e
> current flow, the actual virtchnl message is sent by the watchdog task, w=
hich also
> needs to acquire the netdev lock to run. Additionally, the adminq_task wh=
ich
> processes virtchnl responses also needs the netdev lock.
> >
> >This creates a deadlock scenario:
> >1. iavf_set_mac() holds netdev lock and waits for MAC change 2. Watchdog
> needs netdev lock to send the request -> blocked 3. Even if request is se=
nt,
> adminq_task needs netdev lock to process
> >   PF response -> blocked
> >4. MAC change times out after 2.5 seconds 5. iavf_set_mac() returns
> >-EAGAIN
> >
> >This particularly affects VFs during bonding setup when multiple VFs are
> enslaved in quick succession.
> >
> >Fix by implementing a synchronous MAC change operation similar to the
> approach used in commit fdadbf6e84c4 ("iavf: fix incorrect reset handling=
 in
> callbacks").
> >
> >The solution:
> >1. Send the virtchnl ADD_ETH_ADDR message directly (not via watchdog)
> >2. Poll the admin queue hardware directly for responses 3. Process all
> >received messages (including non-MAC messages) 4. Return when MAC
> >change completes or times out
> >
> >A new generic function iavf_poll_virtchnl_response() is introduced that =
can be
> reused for any future synchronous virtchnl operations. It takes a callbac=
k to check
> completion, allowing flexible condition checking.
> >
> >This allows the operation to complete synchronously while holding netdev=
_lock,
> without relying on watchdog or adminq_task. The function can sleep for up=
 to 2.5
> seconds polling hardware, but this is acceptable since netdev_lock is per=
-device
> and only serializes operations on the same interface.
> >
> >To support this, change iavf_add_ether_addrs() to return an error code i=
nstead
> of void, allowing callers to detect failures. Additionally, export
> iavf_mac_add_reject() to enable proper rollback on local failures (timeou=
ts, send
> errors) - PF rejections are already handled automatically by
> iavf_virtchnl_completion().
> >
> >Remove vc_waitqueue entirely because iavf_set_mac was the only waiter on
> this waitqueue and after the changes it is not needed.
> >
> >Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
> >operations")
> >cc: stable@vger.kernel.org
> >Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> >---
> >v7: Rebase on current net tree
> >    Remove the multi-batch processing loop from version 6 according to P=
rzemek
> >    Kitszel review: the loop cannot work without polling between iterati=
ons
> >    since the second call would fail the current_op check. Multi-batch s=
cenario
> >    is extremely rare; send first batch and let watchdog handle remainde=
r as v5
> >    did
> >v6:
> >https://lore.kernel.org/all/20260619061321.8554-4-jtornosm@redhat.com/
> >
> > drivers/net/ethernet/intel/iavf/iavf.h        | 11 ++-
> > drivers/net/ethernet/intel/iavf/iavf_main.c   | 85 ++++++++++++----
> > .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 99 +++++++++++++++++--
> > 3 files changed, 165 insertions(+), 30 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> >b/drivers/net/ethernet/intel/iavf/iavf.h
> >index 050f8241ef5e..5fcbfa0ca855 100644
> >--- a/drivers/net/ethernet/intel/iavf/iavf.h
> >+++ b/drivers/net/ethernet/intel/iavf/iavf.h
> >@@ -259,7 +259,6 @@ struct iavf_adapter {
> > 	struct work_struct adminq_task;
> > 	struct work_struct finish_config;
> > 	wait_queue_head_t down_waitqueue;
> >-	wait_queue_head_t vc_waitqueue;
> > 	struct iavf_q_vector *q_vectors;
> > 	struct list_head vlan_filter_list;
> > 	int num_vlan_filters;
> >@@ -588,8 +587,9 @@ void iavf_configure_queues(struct iavf_adapter
> >*adapter);  void iavf_enable_queues(struct iavf_adapter *adapter);
> >void iavf_disable_queues(struct iavf_adapter *adapter);  void
> >iavf_map_queues(struct iavf_adapter *adapter); -void
> >iavf_add_ether_addrs(struct iavf_adapter *adapter);
> >+int iavf_add_ether_addrs(struct iavf_adapter *adapter);
> > void iavf_del_ether_addrs(struct iavf_adapter *adapter);
> >+void iavf_mac_add_reject(struct iavf_adapter *adapter);
> > void iavf_add_vlans(struct iavf_adapter *adapter);  void iavf_del_vlans=
(struct
> iavf_adapter *adapter);  void iavf_set_promiscuous(struct iavf_adapter
> *adapter); @@ -606,6 +606,13 @@ void iavf_disable_vlan_stripping(struct
> iavf_adapter *adapter);  void iavf_virtchnl_completion(struct iavf_adapte=
r
> *adapter,
> > 			      enum virtchnl_ops v_opcode,
> > 			      enum iavf_status v_retval, u8 *msg, u16 msglen);
> >+int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
> >+				struct iavf_arq_event_info *event,
> >+				bool (*condition)(struct iavf_adapter *adapter,
> >+						  const void *data,
> >+						  enum virtchnl_ops v_op),
> >+				const void *cond_data,
> >+				unsigned int timeout_ms);
> > int iavf_config_rss(struct iavf_adapter *adapter);  void
> >iavf_cfg_queues_bw(struct iavf_adapter *adapter);  void
> >iavf_cfg_queues_quanta_size(struct iavf_adapter *adapter); diff --git
> >a/drivers/net/ethernet/intel/iavf/iavf_main.c
> >b/drivers/net/ethernet/intel/iavf/iavf_main.c
> >index 630388e9d28c..3fa288e3798a 100644
> >--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> >+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> >@@ -1029,6 +1029,60 @@ static bool iavf_is_mac_set_handled(struct


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

