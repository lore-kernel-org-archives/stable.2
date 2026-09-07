Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D11493642;
	Mon,  7 Sep 2026 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783517; cv=fail; b=MJXEv49RUzX8X704U6meikMQ6xoKVmH7FXa7inQ1KoRUGAt6msXmV+5v5/4pCoJBd0sHZ3xUW74t/JOph4aPR54337oJBQ/cuwHqVnsqPQ+9qWfhoupqDd+Zg2WIxRm+t2yxjLvUgpTWLUxogvK2Y8DEFzAoBLkmpJe0CI85rNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783517; c=relaxed/simple;
	bh=GVWSpngHtZlt4CL50UClDIUxmHnRV/ArhbO/KAtK7aY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIWNZOg/Zq1/h6u11z5oyLoGg2vzk22lXHd9L3nLW5y66Q9ihlG343Irj7rKz56fhIA1bm9UgYXurX5hR0ok/BPK5YMWvQ6S7omTlsm023XwV9HLgAR/3FKN5Wp5gD1F1xKfI+oEy+U/UC0srYaXf90nNTTknI3UuSS1URiWr54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=xhAysdEV; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=H5MVLI6U; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="xhAysdEV";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="H5MVLI6U"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Ap8Gm2843867;
	Mon, 7 Sep 2026 13:18:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=GVWSpngHtZlt4CL50UClDIUxmHnRV/ArhbO/KAtK7aY=; b=xhA
	ysdEVkL6K5xylDpeHjaO+CU9SsXYaRD+Id6BlbFmsCG8FAs/yf5nJnI/R+jmrWTt
	bBCEL5zLFifTqEwLYTKSUjB3E8xINMdAILz/hMkc8y8tdyrcrdBjrCm3VKN+3vf+
	ice7zfAAJ+L3sC00xfbTYF8uUwiW/qS/oBiN2/+Aq+4XoZWERBpBPimedb1XuXdz
	dxabQfa+W7PqMWG8BLJQ33i1Jch9vjALUFtlqr5fSJJ+1JLpawp1b/aH1YyJGRi2
	9kCp8k/QKdgp04H56hOsivJVRl/09gL/BxcDrQQF0JfgseN9QHqUHbkdi6DscgGf
	DVdqV8oRfdK7ce13vaw==
Received: from cwxp265cu010.outbound.protection.outlook.com (mail-ukwestazon11022095.outbound.protection.outlook.com [52.101.101.95])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4ggb5rhq3h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 13:18:18 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUe2ZGMH/bVNGRMZqCjNb+CRXcBVghmMPGMB72/JhfAHSF2pmI4qraNP61b1Vap54CS5+HICR9X74WLAq8fbhuh6dq/8YBytU7uRNc395cfCrb7sxIFdXly9hGKP4fH+0bktk+9gfYbS702E/oK+ju0geqhe3yzLQxrNXK2MfR3WUbn9H15B8CjwFui5w5tQ78UwRIQ+bwiNCbDEEJtyjKFXChAcIboW5Mu+xG0GpgBtwSgJQ46y45hdV4tp9lAY5gv8aIrnWwxHjrt1UTDrfagb0b+HM7hrteZcvjU+MC+Iw76lP1YIj8iUAGRazqa/tLK+eq1BhSvtWEmh/6+0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVWSpngHtZlt4CL50UClDIUxmHnRV/ArhbO/KAtK7aY=;
 b=xi7kDKYpzKIHaUINvNC82ueTwoH3oJUvBKpoOpT6+Q5hhogNU0Ra7uXbB9YYW1nYaYiHcj0jJSoxRzbxMtat43F4wrVFQKU3PSmcu18iuzY9IKeZAkBe5Uc2xbLnXLYvL4CnPFj4bb+3rD70BYsdv+NKtptcxWCsNKvjB0hU2L9GJv9A5t/OBhFvijXl5fOxygcpyjUl0/cJ5EKuEnwVu5ClLVZXB8GdqZ+otr5tBC0Etu0JY8TOoDyFMnJdyvNaW4bk2TrItwOZTRckECS0EONACiAaMoJoFxSMmvnCVy6xQFano+zzW6M1C/fYPWDTnQXetxZihOvsE40pstlK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVWSpngHtZlt4CL50UClDIUxmHnRV/ArhbO/KAtK7aY=;
 b=H5MVLI6Uu8KHf+J3f1q/jP9S+dss8otiV641mjQaoaPPRZyrMV/0DRzpBmxOSDymi1nYh1der9+uSeQ3+X0nRgHxvxomYBxxsqNHOQ+3DtYJSlXiufTpdXyh3btyr2cCwF2WK1cExfOS17Kju/RLEM3pRDJ0qLXZJ5s+I2gfnpM=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO8P265MB7831.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:18:15 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 12:18:15 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "phasta@kernel.org" <phasta@kernel.org>,
        "tursulin@ursulin.net"
	<tursulin@ursulin.net>,
        "christian.koenig@amd.com"
	<christian.koenig@amd.com>,
        "malhyuk97@gmail.com" <malhyuk97@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "dakr@kernel.org" <dakr@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdaenzer@redhat.com" <mdaenzer@redhat.com>,
        Luigi Santivetti
	<Luigi.Santivetti@imgtec.com>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Thread-Topic: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Thread-Index: AQHdPsL1rmj7dL4dAUazn5tZEMtjAw==
Date: Mon, 7 Sep 2026 12:18:14 +0000
Message-ID: <d78d40196bb167fa42f5243548afeb743499d8b4.camel@imgtec.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
	 <20260904080618.2098450-2-malhyuk97@gmail.com>
	 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
	 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
	 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
	 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
	 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
	 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
In-Reply-To: <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO8P265MB7831:EE_
x-ms-office365-filtering-correlation-id: bff76c3e-6d20-40dd-dcb2-08df0cda17b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|10067099003|4143699003|56012099006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 gbUF/JfI9XUUoww3NdTvj4rPFXJZsYjK5GRL11XIPG293/HRLN1W7EYr42UcCZSuNsb38iiZ3B9SJaK2KaS+RAMrHcBqQjmkaxu8zrNTkEVQ5UXBU84vjBA1tkv109iXHyULlmhDux4/9llKA+gkAdN7H3/Agzw+mjvcQ7upBwbIe40RoQiK+837KCAp1yzjFeaQ8BjnVLhvhv1f/TIzw5TzfJX9dgL4lYL2bdvNFqeVACGSYMQj7U0KuS1nzOfqRvKDki4RNuMtPlhO20W5pzcbTA6K8YoMAYH0kjwm18JZZTdGvm5bRvhCLYJHeHVEm5TPOkEYCB2OFqCFvhkNFmmsOeJfVhTbM4T8wGovbQen9V6WpuDzndDle9WqtnqQA9HQNCZnj2tzoZu6nVZ75Nt8wtq8RHmPu495egS0DijiqcVSz7jJoLo5bQWinTSu9FFetH0BYxi3C4xRErv4VI9PUMMOcD7T5WFXCQ2K3cIzG37IeU6xXBL4Adx1zk8g/lSJaUjss+FNmrLfWGVbEdgdFCNzxddfpjxoFmReFlpTQ1ysD+gjG3atOXW9Wj9LL5jXuQYZ+Xbydkfn0v4UZbbnOHqip/grMq0s/YJsz6Amq6pGO/qgrT7E35yQsIIIJbHHbr7e10K27TK3Of6AgmoCHWhDcQF5rEg3LvL5YxmkWfI0PyEp/amruT3h2jDbIcHH7jQu3hxXshHwOxec0thBXCXrPI6YGWN/VSZ8jWw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlNQV2tlMStmcjlCaGRIMW44NjN5ZXlxdWlqa2RVSjJPWmFpY1lWeEJHQ1pz?=
 =?utf-8?B?ZmhPTUg0dE92SnNFVjE1dWlLOHdwOCsvSFJkZXovSFFVRm96YkI0OUVGb2FU?=
 =?utf-8?B?Q0ZiMkZ1dCtYWHhIb2JYc05SQnY3eFMrSUc3Qi9pTzhmZEJXaDdLQm1qMmJD?=
 =?utf-8?B?TmJHbWR4Z3BVZmY3bVhFQjlMRTJZZExud0lKdVdTRkc4S1hsSHRMOGNJTWlp?=
 =?utf-8?B?Nk9yc3lsc0E1ZkgrOWxNMVVteFRQNFV4S1AxcW1SYjZhaW9scjlMeExteTZj?=
 =?utf-8?B?T0ZQKzFYWEptQlFPd01nNHBmQnB3YTBNdzRjWHFBN1ZTWU9WZE1hNU04N2w0?=
 =?utf-8?B?eXVLcytUaEhETDRqeXFkN1BmNHlDSTNTTkNEa3h5N05HSnFhRnlUOHM0Ty9z?=
 =?utf-8?B?c1orTWV0OXRka3dPRmlzdVlMOUNtLys5Sk05bzlraFJvWVlFRFVZVlFRVEdX?=
 =?utf-8?B?SmM0Mzlzbk1kSVZzZ2liVXhjK2dzNlo1L2JSRWZDQ09KOVBtTnpaSWFabXdu?=
 =?utf-8?B?UXpVZkpBd0huN2wzTVlqL0xpNHhrZ2VhRzhSOHMyMmUramZpZUFCNmV2c0dm?=
 =?utf-8?B?dG9UWkxadzFpRDVMRDk2OVZEQzd6dCtXNEhPOUkrOWUvdldIVlBlZDFsTitB?=
 =?utf-8?B?L2w5YmRLRi9EbjlEVjFTblRvWFpQYUp3a3M5WkZXaXBCUGVoNXpHalFldEdl?=
 =?utf-8?B?bStNR0FSdHEveVBFNG9sVVYyNWt6UlhLRHJQcWFNMjRHclU4WGFaejFFVUds?=
 =?utf-8?B?bmNDZm9wL3M3RktxZm9jN0Z3RFNVaWp3cFpuUy9ubVJ3N29OdUxRL29xQjNw?=
 =?utf-8?B?SXI2UWx1N2kyY0FncC84ZEZ2eEdyOUlxdGVZdlEvZ2ZuNExFNVQvSGUvMGFk?=
 =?utf-8?B?aExJRjF0NnlYcVVaTTBQODJpS253NGUveDJDMGwrOXFwSG9xbEpQb2ZRMGMw?=
 =?utf-8?B?TjArdFJQRDI2NTZIV0krc2w0YkpQSHVad2ZkeFdxaE56UmJrRnRObGdjOVdy?=
 =?utf-8?B?NlBhUFA1dmdPaXdQeURmQ25yU3dBeEJGa1lxbXdsK1I3dkxvbmRTOTRscDB2?=
 =?utf-8?B?d3ZNcG9IUk1wSkVuZWx1b1RlTmN6ZUYzek5JZllvNjgrVFB4RnIyTm1aWExu?=
 =?utf-8?B?UVE4dzFDbW5EVlovT1FRY0NwNjJJM0Q3OFU0NjNxcnB4eEUrM2wyTUlQRUEr?=
 =?utf-8?B?RUIzeFFlTW1IeTYwdGFCMXprNUxvU25BNnZUSnNrTHZ3Wk4xbEI1aUZzNFo3?=
 =?utf-8?B?bEpxYTN6VXBqWkVzNDNQVnNUdlpEeDBMOCt0TWxLRzRQMk5EZUVLMzBSVnUy?=
 =?utf-8?B?Mk1iNTFSM2dqcFBnaEdiTWRxK2FFUFNLRW8vZWd4bzhZNk1qcTE0d01scHRT?=
 =?utf-8?B?a0U3b2lSaUdZaWNwcjRFdWo1Rk1UVGZkNVFIMHNlVE9DbzJQWGFRU2Q2Q2VH?=
 =?utf-8?B?ZVZLYno1TytTQXRpWXJXMzNPT2lES2tHMGRJWVZLU1pranJLTnIrNHZRUVN3?=
 =?utf-8?B?Z3JHN1NYdkg0YXlxeklNeC9PSG83Y1hrRG8zcHhUMlMrVnFHc3BiVUFSRDhs?=
 =?utf-8?B?T3I1T3QrRDFrYXA3aDhrMDV4SWRGRXV1cVkwT1hOait1blpNVEtkVStSTXNu?=
 =?utf-8?B?REZLaFhQUktPYnhqSERLQ0lhbjI2SmR5S0FsRmRhdFQ2bGJKOFAzMDBiNWo5?=
 =?utf-8?B?L0xzNEJJTzdrNEpRNEJqZFNFZFovdDNtSUVDVnRnMDF4aHhQbFQ5bFpLTnVJ?=
 =?utf-8?B?NUcwMXJIbjk1Ujg3MjRyMWhZeVY2VUg4TXd1eXdsZWRZSVhaeHMvOUdwbStq?=
 =?utf-8?B?Q0RpM3AwdkFlUS91Y1RiR3Z4N1NWa3A3L0pCYngycTd4bUViMjlaRVVUUk1F?=
 =?utf-8?B?eWxDbkhJRjBsM3dkaURwUlc2TytYV0lNRFIvRDE4VDBucXJiazhJdE9ZVjZO?=
 =?utf-8?B?cnVxSUoxaVVzYXVWN1VQUG94WWVIOUNadVdxbHZyNXVjbVFZcTg2V2ZiV2Nw?=
 =?utf-8?B?YmpWbGJMUHk2Ny9TZWNyVW1teHQybGhnRFNPaW1HVEhmM2w3eFRWd0RITG5m?=
 =?utf-8?B?cEQxcFl3NjhBQ1ZxUWQ5UkUza2FWZHFvc2srSHByUXh3a1RlK3dhTVZsMW9v?=
 =?utf-8?B?OWFKYmo0c2Z1VUl2S1gwK296UHV2UzRSb202UmZveHVPbnU0MHI2Y3FyRmpM?=
 =?utf-8?B?Ui9oeGVsa3U0SkxRU1lSUmhRNXdjYVdsWTA4MnFQcDNOdENxVG9RRTA2aDhY?=
 =?utf-8?B?OExFbXR6Zi92ZDNaM3ZyWWRKblk0OXRLNjhDelo1OG5oRml1elBYOUo1MFpk?=
 =?utf-8?B?QnNPYjRkRktueVdrRFBYb0I0cmxzYVJTVVNHNzJQOGdjb1o1Z1hGUXg3Z1h5?=
 =?utf-8?Q?XEk3BuscP/UnU1nQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06365E73BAA9554B85025171D704AF01@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lopPkp9oTJZMXz0VXpriQotvo9sGHvNSGc2hmmHGAI+c7BIewDrRJHEH6u7K09D9f/+ZdTfMGbKmxgmWV4DdNCcqjmXsvHh1mGm4xOvld33XqI1kCLKCCjnkhrKmMpNvFY5E2fXch3Yzeeoqh/kQISqXPsjbp28nkKYyq0lzmjBIL47YSDYiOpESlkr0jd94qMXVgxh6UeQjvOOB1Ztqch4kX4LJVh6loyzmEuO/fii/vjtXQO73a2kP8kT+JC+kgQ2OdCbvQs+HAtJ/JizzBYA8EkEld/0QW6KOh69TYIpgthC3j51WP3M28pROXLNOG58i8kZB2xApta3k6hd++A==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bff76c3e-6d20-40dd-dcb2-08df0cda17b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 12:18:14.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOAo16/K/N2CtwFz9smmu3Y0ksZjcc8LWZuH61R7QH0aExK3MXIAEpBYIA+Hn7Svmy319mSU+YZijXXfAklIr7JcqyxiVv7runYlg2AIdDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7831
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzNSBTYWx0ZWRfX1X4L4bz9Hk4x
 F2++V1Jlur5dyaMMCG6SoDPkSxprzqw2Wp7NrfVH4yeqNdNEWTBpoWzm2KfUM22hoPLxf30s6mN
 X33CnQzTkkbYBhVQBinktRhLcdKXz/k=
X-Authority-Analysis: v=2.4 cv=c9ej0x9l c=1 sm=1 tr=0 ts=6a9eab8a cx=c_pps
 a=JfQM0q2W3GQMv1ZW29up9A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=_gKKRN3ha36IM0QJSeMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzNSBTYWx0ZWRfX96WwlCEC8Sra
 fezENcW5H0GhraxtkI8GGR9hg5hYWQOmr6qtf+bgL4rdmc8yyYV3eFFJR85c4RlVhpq6FcECzWd
 Rs1UMxQ7nTJE5DIMKyt58EMBAjnz/xcJU8op6SqCDOg2XXVMAgAbgzuxZjJO46WSpRt4vyWPjCg
 Z8BuMNr8sUKJ5Y9zalLXD9xo39137lOTxHzEr/sylYLT21Rc/7Toc6BMjW5tR7eZoVBXdtY0cLa
 N//E9jzfKTf46MFFK9QXoZJR79blklBPniBKi6X84m9ULN5gybchjidcKZ5yyDujOrV4UHJmBpD
 JWbK36SwW90WArCpLAOi8OIA3BCQ1h/Bo+BNeenN2LDQf1Skbj2m3WOu7mPLXMy8nRqnFt4hSz2
 WK6EME8yQ2xwoG7A2aqqIj8QiVLb0lMcbQIZWAOF/R9LtuVjRywIonZzB1n1T5AQxRS7SlaUXao
 Ej91/4czWP1uqidBjfg==
X-Proofpoint-ORIG-GUID: ZoSE9WClYGKw6qbfXQ6xUYmUG5uYRbwc
X-Proofpoint-GUID: ZoSE9WClYGKw6qbfXQ6xUYmUG5uYRbwc

SGksDQoNCk9uIE1vbiwgMjAyNi0wOS0wNyBhdCAxMTo0MiArMDIwMCwgUGhpbGlwcCBTdGFubmVy
IHdyb3RlOg0KPiBPbiBNb24sIDIwMjYtMDktMDcgYXQgMTA6MTUgKzAxMDAsIFR2cnRrbyBVcnN1
bGluIHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IE9uIDA0LzA5LzIwMjYgMjA6MDYsIFBoaWxpcHAg
U3Rhbm5lciB3cm90ZToNCj4gPiANCj4gPiA4PjwNCj4gPiANCj4gPiA+IElmIHlvdSBjYW4gdGhp
bmsgb2YgYSBzdHVwaWQgYW5kIHNpbXBsZSBzb2x1dGlvbiwgc2hvb3QuIFRoZSBvbmx5IHRoaW5n
DQo+ID4gPiBJIGNhbiB0aGluayBvZiBpcyBtb3ZpbmcgdGhlIHN0cmluZyBpbnRvIHRoZSBkbWFf
ZmVuY2UsIGFzIGEgaGFyZCBjb3B5DQo+ID4gPiA6KQ0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IElu
IHRoZSBtZWFuIHRpbWUsIG15IHByb3Bvc2FsIGlzIHRvIGtlZXAgYWltaW5nIGZvciByZW1vdmlu
Zw0KPiA+ID4gc2NoZWRfZmVuY2UtPm9wcy0+cmVsZWFzZSBhbmQgZml4aW5nIHB2ciBhbmQgYW1k
Z3B1Lg0KPiA+IA0KPiA+IEZpeGluZyB0aGUgZHJpdmVycyBzb3VuZHMgbGlrZSBhbiBvYnZpb3Vz
IHRoaW5nIHRvIHRyeSBpbmRlZWQuIEFsb25nIHRoZSANCj4gPiBzYW1lIGxpbmVzIGFzIGl0IHdh
cyBkb25lIGZvciB4ZSBhbmQgcGFudGhvci4gSXQgaXMgYW4gYWxyZWFkeSANCj4gPiBlc3RhYmxp
c2hlZCBhbmQgd2VsbCB1bmRlcnN0b29kIGFwcHJvYWNoIHNvIHNob3VsZG4ndCBiZSBjb250cm92
ZXJzaWFsLiANCj4gPiBBZnRlciB0aGF0IHdlIGNhbiBkaXNjdXNzIGluIGxlaXN1cmVseSBwYWNl
IGlmIHNvbWV0aGluZyBiZXR0ZXIgaXMgDQo+ID4gcG9zc2libGUgaW4gdGhlIHNjaGVkdWxlciBj
b3JlLg0KPiA+IA0KPiA+IEkgdW5kZXJzdGFuZCBpdHMgYW1keGRuYSwgbm91dmVhdSwgYW5kIG1z
bS4gV2FzIGl0IGF0dGVtcHRlZCBzbyBmYXI/IElzIA0KPiA+IGl0IHNpZ25pZmljYW50bHkgbW9y
ZSBjb21wbGljYXRlZCB0aGFuIGl0IHdhcyBmb3IgcGFudGhvciBhbmQgeGU/DQo+IA0KPiBIb3cg
ZGlkIHRoZSBvdGhlcnMgZml4IHRoYXQ/DQo+IA0KPiBJZiB3ZSBsb29rIGF0IG5vdXZlYXU6DQo+
IA0KPiBzdGF0aWMgdm9pZA0KPiBub3V2ZWF1X3NjaGVkX2Zpbmkoc3RydWN0IG5vdXZlYXVfc2No
ZWQgKnNjaGVkKQ0KPiB7DQo+ICBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKmRybV9zY2hlZCA9
ICZzY2hlZC0+YmFzZTsNCj4gIHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkgPSAmc2No
ZWQtPmVudGl0eTsNCj4gDQo+ICB3YWl0X2V2ZW50KHNjaGVkLT5qb2Iud3EsIG5vdXZlYXVfc2No
ZWRfam9iX2xpc3RfZW1wdHkoc2NoZWQpKTsNCj4gDQo+ICBkcm1fc2NoZWRfZW50aXR5X2Zpbmko
ZW50aXR5KTsNCj4gIGRybV9zY2hlZF9maW5pKGRybV9zY2hlZCk7DQo+IA0KPiAgLyogRGVzdHJv
eSB3b3JrcXVldWUgYWZ0ZXIgc2NoZWR1bGVyIHRlYXIgZG93biwgb3RoZXJ3aXNlIGl0IG1pZ2h0
IHN0aWxsDQo+ICAqIGJlIGluIHVzZS4NCj4gICovDQo+ICBpZiAoc2NoZWQtPndxKQ0KPiAgZGVz
dHJveV93b3JrcXVldWUoc2NoZWQtPndxKTsNCj4gfQ0KPiANCj4gDQo+IFdlIHNlZSB0aGF0IGl0
DQo+ICAgIDEuIHN0b3BzIGFjY2VwdGluZyBqb2JzIGZyb20gdXNlcnNwYWNlIChub3QgdmlzaWJs
ZSBoZXJlKQ0KPiAgICAyLiB3YWl0cyB1bnRpbCBhbGwgaGFyZHdhcmUgZmVuY2VzIGluIHRoaXMg
cmluZyBhcmUgc2lnbmFsZWQNCj4gICAgMy4gb25seSB0aGVuIHRlYXJzIGRvd24gZHJtX3NjaGVk
DQo+IA0KPiBUaGVuIG5vdXZlYXUgbWlnaHQgdW5sb2FkIG9yIGZyZWUgdXAgcmVzb3VyY2VzLg0K
PiANCj4gVGhlIG5hc3R5IHRoaW5nIGlzIHRoYXQgSSBkb24ndCBzZWUgaG93IG5vdXZlYXUgbWlz
YmVoYXZlcyBoZXJlIGFuZCBob3cNCj4gdGhlIHN0dWZmIG1pZ2h0IGJlIGZpeGVkLg0KPiANCj4g
VGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgc2NoZWRfZmVuY2UgaW1wbGVtZW50cyBvcHMtPnJlbGVh
c2UsIHNvIHRoZQ0KPiBjaGVjayBkb2Vzbid0IHRha2UgZWZmZWN0Lg0KPiANCj4gTW9yZW92ZXIs
IGV2ZW4gaWYgd2UgZGlkIHJlbW92ZSBvcHMtPnJlbGVhc2UgaW4gZHJtX3NjaGVkLCBpdCB3b3Vs
ZA0KPiBzdGlsbCBiZSBhIHJhY2U6IGEgZHJpdmVyJ3MgY29udHJhY3QgaXMgdGhlIGhhcmR3YXJl
X2ZlbmNlLCB0aGUgcnVsZQ0KPiBiZWluZyB0aGF0IHlvdSBoYXZlIHRvIHNpZ25hbCB0aG9zZS4g
U28gYWZ0ZXIgc2lnbmFsaW5nIHRoZSBsYXN0DQo+IGhhcmR3YXJlX2ZlbmNlLCB5b3UgY291bGQg
YWN0dWFsbHkgc3RhcnQgcmVsZWFzaW5nIHJlc291cmNlcywgYnV0IGl0DQo+IG1pZ2h0IGJlIHRo
YXQgZmluaXNoZWRfZmVuY2VzIGFyZSBzdGlsbCBpbi1mbGlnaHQgYW5kIGFyZSB1bnNpZ25hbGVk
Lg0KPiANCj4gU28gd2UgaGF2ZSBzb21lIHNvcnQgb2YgZmVuY2UgLT4gZmVuY2UgcmFjZSBoZXJl
LCB0b28uDQo+IA0KPiA+IA0KPiA+IEFzIGZvciByZWdhcmRpbmcgdGhlIDAzNTIxOWE3NjBlZCAo
ImRtYS1idWY6IGRtYS1mZW5jZTogRml4IHBvdGVudGlhbA0KPiA+IE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSIpIHN1Yi10aHJlYWQgLSBJIGRpZCBub3QgbWFuYWdlIHRvIHBlbmV0cmF0ZQ0KPiA+
IHRoZSBjb25zZW5zdXMgdGhlcmUgLSB3aGV0aGVyIGl0IHdhcyBlc3RhYmxpc2hlZCB0aGF0IGl0
IG5lZWRzIGFkZGluZw0KPiA+IHRoZSBpcyBzaWduYWxlZCBjaGVjayBiYWNrICh3aXRoIGFkZGl0
aW9uYWwgbWVtb3J5IGJhcnJpZXJzLCBsaWtlIHYxIG9mIA0KPiA+IHRoYXQgcGF0Y2gpIG9yIG5v
dD8gUmVnYXJkbGVzcyBvZiBmaXhpbmcgdGhlIGRyaXZlcnMgb3Igd2hhdD8NCj4gDQo+IA0KPiBB
cyBmYXIgYXMgbXkgdW5kZXJzdGFuZGluZyBnb2VzIHRoaXMgaXMgdGhlIG9ubHkgd2F5IHRvIGdl
dCB0aGlzIHJpZ2h0DQo+IGZvciBldmVyeW9uZSwgaS5lLiBhbHNvIHVzZXJzIHdobyBpbXBsZW1l
bnQgb3BzLT5yZWxlYXNlKCkuIFRoZW4gYXQNCj4gbGVhc3QgdGhlIGRyaXZlciBjb3VsZCB1bmxv
YWQgYWZ0ZXIgc2lnbmFsbGluZyBhbGwgaXRzIGZlbmNlcyAod2l0aCB0aGUNCj4gZXhjZXB0aW9u
IG9mIHRob3NlIHdobyBoYXZlIGEgc2hhcmVkIHNwaW5sb2NrIG1heWJlKS4NCj4gDQo+IA0KPiBI
b3dldmVyLCBJIHN1cHBvc2UgdGhlbiB3ZSB3b3VsZCB0aGVuIGhhdmUgdHdvIG1lY2hhbmlzbXMs
IG9uZSBkYW5jaW5nDQo+IHdpdGggUkNVIGFyb3VuZCB0aGUgb3BzIHBvaW50ZXIsIHRoZSBvdGhl
ciBjaGVja2luZyB3aGV0aGVyIHRoZSBmZW5jZQ0KPiBpcyBzaWduYWxlZCwgcHJlc3VtYWJseSB3
aXRoIG1hbnVhbCBvcmRlcmluZyB0aHJvdWdoIGJhcnJpZXJzLg0KPiANCj4gTXkgZmlyc3QgZ3Vl
c3Mgd291bGQgYmUgdGhhdCBtYXliZSB3ZSBzaG91bGQgb25seSByZWx5IG9uIHRoZSBzaWduYWxl
ZC0NCj4gc3RhdGUgYW5kIGxlYXZlIHRoZSBvcHMtcG9pbnRlciB1bnRvdWNoZWQ/IFRoaXMgc2hv
dWxkIGFsc28gd29yayBmb3INCj4gcHZyLCBub3RhYmx5Lg0KDQpJdCBzZWVtcyBpbiB0aGUgbWVh
bnRpbWUgdGhlIGRpc2N1c3Npb24gbW92ZWQgdG93YXJkcyBmaXhpbmcgdGhlIGNvbW1vbiBjb2Rl
LCBhdA0KbGVhc3QgaW4gdGhlIHNob3J0IHRlcm0gKGNvcnJlY3Q/KSwgYnV0IHBvaW50aW5nIG91
dCBhbnl3YXkgdGhhdCBpZiBuZWVkZWQsDQpoYXZpbmcgYSBzaW1pbGFyIGZpeCBvbiB0aGUgcG93
ZXJ2ciBzaWRlIHdvdWxkIGFsc28gYmUgZmluZSBmb3IgdXMgZXNwZWNpYWxseQ0KZm9yIGJhY2tw
b3J0aW5nIHB1cnBvc2VzLg0KDQpXZSBhcmUgbG9va2luZyBhdCBhbHRlcm5hdGl2ZXMgdG8gYXZv
aWQgYWNjZXNzaW5nIHNjaGVkX2ZlbmNlLT5zY2hlZC0+b3BzLCBidXQNCmNhbid0IHRlbGwgeWV0
IGlmIGl0IGNhbiBiZSBkb25lIHdpdGhvdXQgbG9zcyBvZiBmdW5jdGlvbmFsaXR5IGFuZC9vcg0K
cGVyZm9ybWFuY2UgYW5kIGhvdyBzYWZlIGl0IGlzIHRvIGJhY2twb3J0Lg0KDQpUaGFua3MsDQpB
bGVzc2lvDQoNCj4gDQo+IA0KPiBQLg0KDQo=
