Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793626154;
	b=Hlx37L5FHkJNIz0lIP5fVowWr5YyXJM/sE9mGPxIrJVLy/p1fhE0p98QiEe8d2D4np5s
	 bmy0T7r3ZgjpHWFTbqY3iEL7ZzXt14gRfaHRhK6P1ot8WO2LgPAAn9spXUoTk0mQ6Farn
	 eK1EWo4zX3o1Y1aCc0GeSEowARJosokEMV4KuAQs0rV0HLrMe4CwK/RehBiZB2mN2Kbd6
	 wOH0Hc3F/KWn3AewNMxfkilha0Jti1ecb0j906jeAvHtMqivbYFhv9ueBdFSPHykV+3Wt
	 kTJDPmyDKyKbiygCH85MGfEwUK/WeQM2cgAp07vdwVVNtXN2ClPmKwSeH92fyMOfPXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626154;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=KeI41U6XswzzwkZh/tC2K4qiaVkPBa2K9BWwm0kk4sM=;
	b=v3rhkFJevDJ9yscJD3k/1tzdaLjIQC54xF1oeuSZ/PMLq+ZGOrT8uhlmo/X9isRivjOn
	 oAUJpMWSjUHuu3L2L2/oQ5rFTvRzb2Wa9asXW/jc8UkA79JkKvM0sOsFvcgFfe2CyIALK
	 CuwX2A7kPaTZ9f/FNIlULPqYo5JF89dhb3LM6NScfjVlwy953JezQarRFZYX0ldOyiFWQ
	 Dh2hY+qFOFna1pwdPlneGT505xGS6xqzOj39C+eLhFrq535+NnnOvZji373kwx+uu+fbJ
	 10bJcB6OydDSvyWR00G5IA/8pdG+L6MeX21qi+kjsD8uc9vHClbPSEH6MMlu7vcg0CA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Imqjd5Yt;
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF1606A326;
	Mon,  2 Nov 2026 13:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61EF1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Imqjd5Yt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793626152; x=1825162152;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kMtkbb8bTHuFKDk9wady43vaR3qihpKGIJ2VSuNSFLc=;
  b=Imqjd5Ytx0+Vzc8MxGVPZi3RkVmcn6nQLmLZifXBtdZctHttjf8WfWkP
   eBLP1ErCRmuBT/5GAnuiqWdLD/Tq6c1AR/1veI7bGdZy++hEUS/pJU9of
   FbWoHZRgRaGDTtgW7gF3BWhQim8BU/b1zZpdwbiysgEoP6aU7KUyobVDq
   1klFWbij66hKI++h7OnOXUqg1z/qBWZV3shtTc2oGA+RLi11+ELycfk6o
   0i4WXqqGf7UYKUJQQdrT2PM2Q1ULw1HFFg69hbbmvSpS7KOmz2DVjelkO
   4IkM93IwWkPNSgatcby9D4hBEZjPbuMV58QeFfAPj+n1fv1W2eQc+bWtT
   w==;
X-CSE-ConnectionGUID: yB4qSScERU6aHTqYpR5/vQ==
X-CSE-MsgGUID: 7mEom9nVSduxPlbCy9OPZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2327731"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2327731"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 05:29:11 -0800
X-CSE-ConnectionGUID: PC6UjmqmRH6VeTUwuzIPKw==
X-CSE-MsgGUID: ZtOg+AWsTk2gc+HEAZJoAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6668559"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 05:29:11 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 05:29:10 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 05:29:10 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 05:29:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mw/MfVVT79FzxLep4oclffAv2KiHR1NLBkwvdMfOosY3qhMm/5OCgUSYDqKVajR4moKU8bWH5rZMt953kT+SoM5/D1qi0FXFezLVAI1wR6Hd2su1r0A6hgbqrp1yA7DVmItYJAPrKubMx0XxYM/cT/aWlAIjHdB0AgQmkxsIyH5hI8aJHqsT02QHebirLWjDpw2gERbUMknf9TtWVBEPkkKiJ7JWosgjo04UyA3Tt1V8rUkRbSrj5IU4Z2Ms47hkpOXW+pj8F6M84NkEkOSeZKvGVud7dIUAv74Szbu260KEjXnHJI6Tvnu1a+8kZQPAg4IBvdtB25KR70GyZ6ijaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeI41U6XswzzwkZh/tC2K4qiaVkPBa2K9BWwm0kk4sM=;
 b=uUtzrrxknGJKYvxYUwRkH7RQ0WRGct+9K/BPI4VjgcZqArN5ndS6mCx1CRiNuim1rLAYLSWZU/r+1k49VypS4eqbdEuWlXhcO7O4d31dlfUCMq6sgLpnFfAVSMlAiu3Bep4qvqAPI8u3+blz4mFuxYR+76IH2SCRKn4BjsZBX3vTo+WOJ4DJmdpX9VaF5/q2XMyH3USKj/iwXLPfZ22NLVmQULo7vLK2msWI91u1+GcKlYHa+6SfAUBJB+bHpwUE75uvMNCphax1B2khkAZ6Y+zbcH2ut8RYQEp2iO/h2UES+/Dbkaz6fkcuVgvIJ4u4CI3AJwuV+rztqQ2uciiTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CH8PR11MB743968.namprd11.prod.outlook.com
 (2603:10b6:610:705::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:29:08 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:29:08 +0000
Date: Mon, 2 Nov 2026 14:28:55 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <tkusters@aweta.nl>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Sven
 Auhagen <sven.auhagen@voleatech.de>, Richard Cochran
	<richardcochran@gmail.com>, "Kurt Kanzenbach" <kurt@linutronix.de>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Paul Moses
	<p@1g4.org>, <stable@vger.kernel.org>, Piotr Kwapulinski
	<piotr.kwapulinski@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Alexander Nowlin
	<alexander.nowlin@intel.com>
Subject: Re: [PATCH net v4 0/2] igb: only strip the Rx timestamp header from
 the first buffer of a frame
Message-ID: <auiQF5ZxaBDza8xq@boxer>
References: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
X-ClientProxiedBy: DB9PR05CA0015.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::20) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CH8PR11MB743968:EE_
X-MS-Office365-Filtering-Correlation-Id: d70c57b8-bf36-4914-fd75-08df38e545fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006|5023799004|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: +nZESC3OKcxgWcp6eqNcwgLViQU2/DjxS+OOTnp5eAwTB/GRKfTloNYC1NGFOuVmDex1B9yOtgfrRVgd4z+8IkBijx43OwquF5HmmA9TN7TWPffnxWG9HB4U0+iyhGkMJ90b24XRFvYq5Q1kD7stbbrt2u4RxBam5dwezyM7sWrvuI3Hgvt6xzX5x1HyF55navrWWDRbxhnIKrEvwAOS5m82abV7cFQ8Y09rZsQaUGq9GiKy294cQnGnqdxGGTKm39NAu2QF8qiZk2uNG9VSkXjK63hgLao1r8xmc369Uodtyq43fN7Kazcc0XhA6W30tqi0wUSJ/NYM5OPWbjfGWfTyE82CzAGSxCFsK10j3G0zttZQ8bRpH+1balnRzK94UYVejUc3i+ZWq1vYV+C6mp8BJ/Ngj0+wzZAvg3Yx0vYLvkxyAiuIt/3rNoqfSM5LyLHE8RxSk2n03gV5ozdYA1ypBK/adoCKYdz27xeY64h2LKfr5Q/dWmn01lnm8yUwY1/i/AC0qdRIonsVHalnPkRkmEkEySwONP3nFgX+SUsj38Ijryt4truHCXApziYe/br+mOAThJwQCt8S7EBX7QxnFmFXEbYgE4V4bt19q07hUYEb5EPtLOxrJIe5C65a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxrD9j2xxGUMfYMLNxStjSDAfr1tT95VSb7Sun/u0ogfp1D0BX779JqY907O?=
 =?us-ascii?Q?8CnLfWqhpwJpNT4fts7JI4QWjY00x+xmUMZsFMacgAvXtsFuI4SDMl0seltj?=
 =?us-ascii?Q?egZX6SRB4NyyQ8elkmylgD/lYmy736sd6s3IHG3oA6iUNOMNjJ6Xq14mkyU0?=
 =?us-ascii?Q?Qzr7+j7eYHsEHz+BQoc4Wr3FHiEdX2kwRsYzx1K5ORWX2Efu9GiMxLHYTo5z?=
 =?us-ascii?Q?w5B3lsq9GL19WPQuq3Rnol8hSf+T0WtUJxD83ByJZbDiMILdctynwTUFbQw7?=
 =?us-ascii?Q?Q+XPd6LRLWyur1OT/pO6fPg78XU9G22OquwzjHCrweD4SLI4/qPdOZXtnARw?=
 =?us-ascii?Q?I23WxWX69tNPQyLODl8QyrY5Hxi2YoDZFH57FRgMcH5rbxQHhKM61p2bgDj9?=
 =?us-ascii?Q?KI8jzdG0BgAPwA05d+lWxkqP1m+HYrwifOt/pvvwpyuHngT/HJSgaclXkeN+?=
 =?us-ascii?Q?HZt8zHnuwaFZXERWzTzdJKRgrMuxU2Sr3JlRH+dcN05F+yprkxO61KjVlhG8?=
 =?us-ascii?Q?X/VzgLHCd9IGGqNigzHuQzieXlh3TUCyB5d6zVBpbVze/xZQp2LpZ/Eo6/pC?=
 =?us-ascii?Q?rYN0gbSOto4h/w8ke3EK5lvWZkJjhsVPdCVPGMYVObQIO8m+RqU5JNpAO3Fx?=
 =?us-ascii?Q?QI8Y4ApjMMTjyPsM7Wg3OEr1Cdt+FuIVlIrf9B2fT41nBNrY9NuoQ2T37VGe?=
 =?us-ascii?Q?k1193ivY+yvLYIoQUp+vu+j3C7ifaBoQ654yreKEA/9w4ZdvBnD5x6oVUNV+?=
 =?us-ascii?Q?Aqduk7B7+wFpbudNSwOAPJ13sI+Hu/acDcM0NFAfYQJilBFWvgtk6mQc9CDt?=
 =?us-ascii?Q?WYAxFpy4cwmAt/JWO7JNsG6dJS4dGyBb97XjzMe+F/py1tR+/1BR3CR5q2Q0?=
 =?us-ascii?Q?Vi5ihDywsytSi259OIpCQV7upBwR48rGgg8JRq7vrXXtzE7H3ywz74A6P8Dx?=
 =?us-ascii?Q?8F8t9mpO/X6/l3iN5nxjV/t8FXnpL9SFnJu9/pGQyy65SJHNovLHZasuRSzP?=
 =?us-ascii?Q?EzXMRsMvnDQm+Gxm5TmO7VWi+Br54mk4drDjri92lT8Y9kzzfJvJvc9ehzYp?=
 =?us-ascii?Q?u24okGrRXCsP3gAWwrDYcaa71nWsqfwXvdFZ8BQ+BW1lbZfueOCHW4kal6iY?=
 =?us-ascii?Q?sMtXsnnk3SVHxNfB9u/2OKpB8UucZXYegYJomGabUGysLPvPG1JlReWzelIY?=
 =?us-ascii?Q?WV504RlGKE6Mvtllv6FbbLEIdgFt3VCJAHMxrjdf3KPwuJqNsopJnXpUXfOp?=
 =?us-ascii?Q?L1L6+47ZU3beV7BgtNU2T4XKbxVdPo7P/6dJzhSVCQUdEJQkLjTJsFyd8Flk?=
 =?us-ascii?Q?nLAic5v5Rl9EmA95GzLjjUzR5159abgB+86uIXCqNWTyuVzTtAh4P/wzIpAD?=
 =?us-ascii?Q?oLzbxjj+f4JOb6vcYKD97K+HBteGbqxIaLqUl5AiAu4y9/H9FjGqVUyCR3Cm?=
 =?us-ascii?Q?d7ZERV8pwcHg0BpI5ySY6R3FSzQUxcK+l+TU0yRM2QuLIMZ8re8Efh6jPcNr?=
 =?us-ascii?Q?fRt9viS62K5l9unQKVAIUPC0dYZghoFQjgXtl5c5pQTyUFwAobY1UtjNtdWF?=
 =?us-ascii?Q?JRlvlOD4poHoShA23O3fVq0rT5NazANz5mE1Ht2fNrUi3DqsWwvU3Xos7INt?=
 =?us-ascii?Q?60y2defLUwQA2e4Re3tcIVpffPpZhkRxFA3Fx+oyqmgbedV4K3M0waCoZJQQ?=
 =?us-ascii?Q?u2JL7mjohA3KRE0oUN1kLGusdVITMUvmAGJg9WsxQA+uUcvonc29GPhIl4Ri?=
 =?us-ascii?Q?gfftuzK3Ah1XbYe9QDv+qn9wx/Dxt+0=3D?=
X-Exchange-RoutingPolicyChecked: pSnGRk8c7hfQ2oxwzszOveXZAY4R0RX/VvNRkEFGz0n7TUA74NzbzD8WgV0smo3M7SvMmgNMlbvYCqPZrM27e7dO661RUJG57457IETWcF0CkYrBv56IWYASqtaBSJ/Xa/1ATe7VbNT9GVAbNFvCI7bYMnzKBD+fPkU+xfmqBbQt2qhnm/ZeiJTkrUuzdWedJFKBKREx68Adr6o8+3WRkduEj7ynKyoETR5eQOQAxTvAQtIm0U7ZfT+RPo7AGeWMLkzOHLqmMJk96DOk03khkDrn0pQBBNDbiuZ+W/QkwJk2wWuK77C6sFQHtBsVFmbQ2rt1Bnl0ctgqN2xQC5n/6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d70c57b8-bf36-4914-fd75-08df38e545fb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:29:08.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axQU7TEebLPDuVD1VpGacsVE3ZTfdAT8Ei/avCqXheg7AGllJvvIcrahmMcsH5DwFCG7Xw3u7GYXRQtOeo8MzTX7tD2DRhSCGVsqz+A06kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB743968
X-OriginatorOrg: intel.com

On Mon, Nov 02, 2026 at 10:58:12AM +0100, Tjerk Kusters via B4 Relay wrote:
> With Rx hardware timestamping enabled (e.g. by ptp4l), igb strips the
> 16-byte inline timestamp header from every Rx buffer of a frame instead
> of only from the first one. A continuation buffer that starts with 8
> zero bytes loses 16 bytes, so jumbo frames with zero payload arrive
> short and are dropped.
> 
> v3 used skb == NULL to find the first buffer of a frame. The Sashiko
> AI review pointed out that this does not hold when an XDP program
> consumes the first buffer of a frame that spans several buffers, so v3
> was sent back for rework.
> 
> The same question came up for igc. There, Maciej suggested not to track
> frame boundaries in the data path, but to make sure that frames never
> span several buffers while XDP is attached [1]. Paul Moses' igc v3 does
> that [2]. This version follows the same approach for igb:
> 
>   1/2 limits the receive length (RLPML, or the PF pool's VMOLR with VFs)
>       to the configured frame size while XDP is attached, and leaves
>       room for the timestamp header in the XDP buffer size checks.
>   2/2 is v3, unchanged in code, with a note that it relies on 1/2.
>       The Reviewed-by and Tested-by tags of v3 are kept for that reason.
> 
> Not addressed here: the AF_XDP zero-copy Rx path. igb_clean_rx_irq_zc()
> has the same unguarded strip, and with 2 KiB UMEM chunks the hardware
> buffer is rounded down to 1 KiB, so frames span descriptors there. The
> igc counterpart is Maciej's buffer-size patch in [2]. I do not use
> AF_XDP and cannot test it, so I would prefer to leave that to someone
> who can.

I assume review bots will give you a hard time if you don't address this
within your series. Seems you have HW handy plus you do use LLM so I don't
see why you couldn't ask it to address AF_XDP zc rx ?

FWIW blessed user space tool has always been xdpsock:
https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example

so you can ask llm to run this in rxdrop mode on receiver side and feed it
with some traffic from peer side and then see that frames were not
fragmented.

It's easier for you to cover this as you have HW.

> 
> How to reproduce
> ----------------
> Receiver with igb (eth0), peer with MTU 8228. hwstamp_ctl turns on Rx
> timestamping with filter ALL, no ptp4l needed; this ping method is
> taken from Paul's igc report. One host with two ports also works if
> the sending port is moved into its own network namespace.
> 
> 1) Truncated jumbo frames (patch 2)
> 
>   receiver:  ip link set eth0 mtu 8228
>              hwstamp_ctl -i eth0 -r 1
>   peer:      ping -c 5 -M do -s 8200 -p 00 <receiver>
> 
>   Without the series there are no replies, and IpExtInTruncatedPkts
>   goes up by one per frame. With the series all requests are answered.
> 
> 2) XDP consumes the first buffer (patch 1)
> 
>   receiver:  ip link set eth0 mtu 3000
>              hwstamp_ctl -i eth0 -r 1
>              xdp-filter load -m native eth0
>              xdp-filter ip <peer> -m src
>              tcpdump -nn -e -i eth0 'ether src 00:00:00:00:00:00'
>   peer:      ping -c 3 -M do -s 8200 -p 00 <receiver>
> 
>   At MTU 3000 XDP can attach, but without patch 1 the MAC still accepts
>   the 8242-byte frames, which then span three Rx buffers. xdp-filter
>   drops the first one, and the rest reaches the stack as a separate
>   frame with all-zero MAC addresses:
> 
>     without the series    5154 bytes (header stripped twice)
>     v3 alone              5170 bytes (stripped once)
>     this series           no frame; rx_long_length_errors +1 per frame
> 
> Tested on an I350, kernel 6.14.9 with these patches, with the steps
> above: results as listed. The v3 line is from an earlier run with an
> XDP program dropping ICMP. Also checked: XDP attach at MTU 3030 works,
> at MTU 3046 it is refused, as is an MTU change to 3046 with XDP
> attached. With two VFs allocated (booted with pci=realloc), step 2
> gives the same picture: three leftover frames without the series, none
> with it, as the PF pool limit in VMOLR drops the frames.
> Not tested: PAGE_SIZE >= 8192.
> 
> The patches, their descriptions and this cover letter were prepared
> with the help of an AI coding assistant (Claude). I reviewed them and
> ran the tests above on my test bench.
> 
> [1] https://lore.kernel.org/all/20261025065154.2037149-1-p@1g4.org/
> [2] https://lore.kernel.org/all/20261028083344.3047350-1-p@1g4.org/
> 
> Changes in v4:
> - New patch 1: limit the receive length while XDP is attached, so that
>   skb == NULL reliably marks the first buffer (Sashiko review), as
>   done for igc.
> - Patch 2: no code change; added a note that it relies on patch 1.
> - Link to v3: https://patch.msgid.link/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl
> 
> ---
> Tjerk Kusters (2):
>       igb: do not let XDP frames span more than one Rx buffer
>       igb: only strip Rx timestamp header on the first buffer of a frame
> 
>  drivers/net/ethernet/intel/igb/igb_main.c | 37 ++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> ---
> base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
> change-id: 20260619-igb-rx-ts-fix-cd70585ee316
> 
> Best regards,
> --  
> Tjerk Kusters <tkusters@aweta.nl>
> 
> 
