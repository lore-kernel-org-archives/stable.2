Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9785364053;
	Sun, 19 Jul 2026 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784449360; cv=fail; b=X2ANoi0mdh/ghDu5+RzQv3EtMa58o3dP/VRboB5wVxHrL7njvbHGOyVqyfBMm+WIQRALsE1I4apDflo+j/lcGh4jf/iDr5m41VKZlxTCLxjAZ7W/bS/oldg7bFoSQkd83Q0CHfPcnO2mJCcLBmdHAeLpLOstDoWV7d3W473P7WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784449360; c=relaxed/simple;
	bh=ZJo0J9NcUG+Btg1+taD2MLUVNetxIOc7rTLe/jjKLKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DFQcAzzsA0F2dCPA1aipEvdYpHhqrXfaEHZysEiqM1TlBlqHA0k89uGFooU2rvjlDh21LtOiUfmCufJt173xlU0IY+pOwIr7t1egr0Em+aUwh9KsHyVAZVYKR3CmND+ADXbl2lvkDGLudxJt5PGWZ8k/T18N99MjkiRdN+f0nPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Maf06Nvx; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Maf06Nvx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKAjjTPPEW6HTTp2h9Pl7b0mdS3d2appFdPgUy31naypC1+XMpoPpLh8RHtSJW1wzhpaVM4lHEmnap3VMqYsV/dNKtyBd89BSjRxaA2HXzI7NppG5HaiTpwL0zq8avGjnYwYcogdZC/NL3ra+6BURM7bUj4xG0fPfD2j3K4aX4HBd46DvtDHQxcILiq7oyAqOTpPZNG1xO36kdS5601BlYUolkPsUCJJ6kcRsTdRBBsRtWzdV7CEF9vXcYnz6cx87LPqN01gOBjTaxIe9eAnkOJd7G63ZCmlabx2MXBLI/VYwGLY2RbrO/qsPwwuuiinHTgT748cHjwuMVafUnb4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8V+4Ck8oM3tZkVpNInQJ6NsbFGyc+mcm9U15pS7afQ=;
 b=oNXamb+MRylMtHcYEcYGUMCIOEw2rZKdSaOnWlmY/XR/Iuzq9cGm0wIc8ekJHwvKU32wUhpQwCM0BN2wwC7hJEu3FZhNe3DCkoBOuJzxgQ6C13I85JkLAaQ2H4l2JOISYSSfdPremgeYRXVRM58nqlv6CShcKRdrF30/u+YMhAi61GKVxIoe4g2Mnya1SXX2E/lFLAXAy/26nuM0Vpz+9FJNEKT2280AuCPPVD1uU7JSi+a/qPgdsBcwsSdqSXrh3r8krfPdjVNxZsYVSf6wu11cWBVqQPXNG4R0T6e7DfaQjgWzzrIXCL+ElQKmBpIOUIiMeWBajjlAYC7m7bEqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8V+4Ck8oM3tZkVpNInQJ6NsbFGyc+mcm9U15pS7afQ=;
 b=Maf06NvxRGg29js0K96LYf+RYRVytxi8ygjeD9IbpgrivgRNWw0mMpYHz5N0+9E5rioJC5PpFopNp3WjNHoblN7pOkjPuKyDo4TSrMUw/iQ53cB0nUfOoui+iKyFvf0W5JeRAxoy6UdrzX0dxECJf/O+8KqFAa80lEyf9T7/BpFq+BBuNn1RtNwjYu6DAH0H7G5l298Zcs7p/Vkoe98zN4yT6nwCcGCrqGvi4BfLUrecv8eKBSwlIR7GNu7zq584driVRetq47S2YOl9zk/f0Fz6D1sPUECumW4ULWJfziV5CwPkcvhwKT3RtZGDmvCgl8X4ARCbfBndyJGZ9caiBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 08:22:32 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 08:22:32 +0000
Date: Sun, 19 Jul 2026 11:22:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>,
	Linux Stable <stable@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
Message-ID: <20260719082223.GA1899043@shredder>
References: <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh>
 <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh>
 <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch>
 <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
 <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch>
 <CAE2MWkmbdDrCw1HUKm17QG7dyihuxg_1VGTUNeBq9v8NVwJV3Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE2MWkmbdDrCw1HUKm17QG7dyihuxg_1VGTUNeBq9v8NVwJV3Q@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 623cec07-355f-4cda-7367-08dee56ee16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	DJp8B4WOpHEgapqliGmBw8PTO2MV/qMUgnXWMLv4S8aQRyGbH8CGtOtz9o1WKqLmMJMbquJAq+od6mLSitkqXMH/mfIhpumfXZgksZ20ZF7GG5Zx/o4rh8FJYpQKzsHqybuEtcufK+/avQdNWucR7JHtl0r6UmAO6QurYyiA+p7UK5EDMYQXdkgvoim2rTb80o/uLxWFlI8Z7+9IP8y0BAPT3ms1o6BU4KIZTDzSth2NYIjuYqrSZYHA7Tzry8gfCOB1l2UVRI3iNVkwEu2BmKNDIQVuMAm5TUdMBoLoGosqTYIdCwiJg8BCbx+mUTHyaxz/AdMdLB0ov5jLj12EAyXY8RgSChQMxEhXXvE7mKQGu5h2g85Z0Covqx2UoQ8+B2PrTi47iMgC0Siz5CVGAEWRbYmzUqZo4cCZjKJ/UbPwrTeHKynckjh/OYmiidJGDLJricHjvjQOaK/c94R2PndOffIfRs2uZpw/Y2mkWXeUALbjOFVnwseJxztFoS1iNgMo9kC5eRYABoFZUCGVX6mdJ/2oU8uTiQAyKwfLRQAy7UMzA0DG56qVXNQ7AqHvUPm1ct7irqe4Vgirlp9Uhj3ooCn3jBiNrMb5h62V/eIY4yWqnC0kEMbZt6ycwZ+iMF42RGWxQrOqUwubKcySTcJ/Y7psPOlg/PzO55uwWAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C+xqHWqWTzLehW3+Wmuoj8/9Rf6aV1wqQTuWYfzsuXTMyMn+QFvxfzsuKP3C?=
 =?us-ascii?Q?jzEHLShqNEczxkxf3BJ609EeVXsBJc+j0xj6oNy/memJPbTS7gwVT884eAQr?=
 =?us-ascii?Q?WglT+Cr90qbBEtHkTIbWI7LoUZMeeSF4CFxqwl2Yo8aTgFBhuIf4bhT6pijD?=
 =?us-ascii?Q?QhrdC/BkUfgl+wke7QOl8fRcN9jkaWNFvZLALrdlwj9RJfLKm8BKzdSCR9xD?=
 =?us-ascii?Q?EkOml8Futms9KVJJCEjoDZnJTvfhPUZfp6Sy56Fi68imXFeH1IUR8lheoM/j?=
 =?us-ascii?Q?x3t8PYf+PiJb2fceRZQ8mLl9IoA1gfLNJ5GTzVzpVdMjXGeE5Lc4nIphzu1H?=
 =?us-ascii?Q?ak6yOokS6FgjjihRXd+Is8FSpbmwEVAS+ZgNfi3i23F9pMGFJ57ePq77NkCB?=
 =?us-ascii?Q?AT3xV81iUY/FksoVQ03Ifgp6N0t7hDRFyYhd9OqbvUDRAitpK93Ks55Vb/kc?=
 =?us-ascii?Q?1jI5H87LpiWIFrVhphU+ndy9OdVVMyPJ3Qd4KCyxtX6lnn501OFAIxa+7uff?=
 =?us-ascii?Q?8FrIDl+mUvp1iPYk/ZizkGr/1m4+QSmy9G+g5OCFbsfehM4p3kw7dp9Dp851?=
 =?us-ascii?Q?j/LK5ATATPYe/4nZB3DGjm69EmWtYQQjhwnRHSc8SCQppCZ6pOhfnY7K2Eyk?=
 =?us-ascii?Q?bCIXSujEARyDIQQjelHMsIZdu0ga3fgv8QBZHfygLkBxjIEt3AVDBcjGysSb?=
 =?us-ascii?Q?PeJ+4jWbZorYa9dU/z5azCaEdLuuL/jM7G66fnljiFM4/agYywcvYr/xE4+l?=
 =?us-ascii?Q?lGl0FaI08hAJH3yqlHZMlzuwODTWB2iGSBaW43r3F2Lv/qcSUrwbuxzqbLrd?=
 =?us-ascii?Q?lW4F2jAbZz+cZAKsK/0NglMVfpgRXYohSSoW/eM3IIMVutu1sz3fX2ezmfVg?=
 =?us-ascii?Q?UAyK04c9LVDP0hjCFNnnwNS1+cZgAJhYOYy2NnVvcLSBZV+beNvORS2h1P9i?=
 =?us-ascii?Q?G2YOHITbhpUTiilpZyxhqyoF6CZcX+uU2KzhKRJauKSRwWrUtduhuDmGfgX3?=
 =?us-ascii?Q?4ta4ImgIeXJdVpPhv5M2jjE2s7CUOvoOhoZKovl/GfbV69E2RtCB1UGP9MHW?=
 =?us-ascii?Q?b0oCI49fStVkFZm2TEHcc6c1FNZRweEbSjiD0wPkyzbQVYAhzQT9QMjVUdp1?=
 =?us-ascii?Q?PZxayCa7/hyKbLsCJ62PYTNr4ojurexMfkOFsB9/FoI65W6ke9Ubb6B2chGL?=
 =?us-ascii?Q?eftdYKSLVxsMCzyj9KR9K+9L7+zgKu0MGbDTRqhSgF3XA0uGxTCSuh6rtSTe?=
 =?us-ascii?Q?Ga1F/lFDvaULtf8gyA76x1SXAdN3Dhvn/3h6Z86LD5p2RRfCp0EPHnus5Ui2?=
 =?us-ascii?Q?uxs4vHkcDfmokmSC0dtrYXC17YyVH7Xk+Z5Oxy11WCqIBo/kmbhdq2P3UXXB?=
 =?us-ascii?Q?l0/gcGDJynMs2drwU6xUGzADXLrGVDWfM5BebcqbTmvs8Br9hCPm1XkIslkQ?=
 =?us-ascii?Q?TMsRZBT98GGL4ehrO9Fodx+vYUoeuiOBsewb808jfJpnalN4sOIkAg2iLiAQ?=
 =?us-ascii?Q?f9Aom49SbYfnHjsSz0X44J53NMEEEqM0hm18f8Vs3Szf6lPL8CQGoDSe9bXC?=
 =?us-ascii?Q?AKF5TUm7HB6ThaXGfUzKMXgpj6bxpggDSr1sqjVr7lnn3BbzCIlBdu+mmJ0T?=
 =?us-ascii?Q?8CWThRYT3OlSQ+zNCbjbEXM/S18zffSGbjeIoarZjMHrEmON5VmEwK/Pdspb?=
 =?us-ascii?Q?8xLncN1YTTl5ktXiF5DKPEfi+uzHFr8GA7JLDqRLOYrdBr/C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623cec07-355f-4cda-7367-08dee56ee16d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 08:22:32.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDvU+ldpk91L/cdllvEhg63X1s1zVBfFYERgVF8tTp2gTzSrRULagSfHpjAcT2wD69XahQaw16WFAXM53UvHgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

On Fri, Jul 17, 2026 at 04:12:09PM +0530, Ujjal Roy wrote:
> > It does not force the users to use a value < 128. You would need to
> > return EINVAL for that, which i'm not proposing. Returning an error
> > could break user space.
> >
> 
> While I understand that clamping avoids breaking user space, silently
> modifying the value might lead to unexpected behavior that is
> difficult for users to debug.
> Because of these side effects, I am hesitant to proceed without the
> Multicast maintainer's input. We should raise an open issue on this
> topic to get their official decision, otherwise my preference is to
> ignore patching this for the stable kernel versions entirely.

We asked to target these patches at net-next because they don't fix a
regression (the encoding never worked correctly), so they are not
relevant for stable. Users that require this functionality should
upgrade to a new kernel that contains the patches.

Regarding the stable-specific patch, in my experience, stable
maintainers don't accept such patches and prefer to backport patches
from upstream, even if it results in more changes.
