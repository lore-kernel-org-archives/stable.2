Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974C3655F5
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120071; cv=fail; b=ViFltQ9IubSHGYwx4M8MtZPp0OfeWP4p6F3QIj/b9tfnqB2x11I/jPCbRHVr6gQKWA8eJ1XJOxUjol4IL1lbrB4yZCZHynnkqR0Nn07wXeLHIN1c3FCSidv5ht7ePDrNe5347ULglHe/avIwsEQVuboekgu9a9d35A6XIhOAovE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120071; c=relaxed/simple;
	bh=+q4flEnRL0ZqRMafGVOZtDy3Vfn4WPJDw3rNOKraumc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JeaEYkw54/A23v6CxG4NkzNZJ/cygAn1i7MZ9FMEo2ujY+zuaG9r5oiLAz5SL+HL2sUbM7A876n1YV8sdXXPj+/qfq+YR92+LQp2PaqAdjQyqNBmmdbq5+27fMKNpsGybtviWfopEfCig7fhjxcQfI6TMB9IaejwyZL2bNv0ceo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rtcHiP/3; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rtcHiP/3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay9xkGfiXQ/Qypvv1I8VWQe/cmCI5uCFG2C2/fWWQX8bpjv5d9dxxQwcTNtmCWvRfvYZ/FfoHOil08/24CePoDNQO5FIiyQE2TA0MB9g19A4VRUj5/mQbcAbpMDw7a348e0yAWs+RTUJKCjJWsPUKUED5fIKchxzxshaZOGFlEXqv1y9f1SCWUguhQNUFqyDkLiUvmk5f0eUa//wJeyS4wh1it98aDXyyWiuQbhRf/LFrJcojJuOpYLJso+lEVGvvpI99+dcVgyWnpbL5U1piH424Sc+dR3jxmcaj9di/1es8Rr9p3yoFj3MpQ8DrfEGKZZ0HgokyEOXlpu9OJ3/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDJLVhriJK0wd7O5IVqub9YKvXpsgtg8XmSikMDJ06A=;
 b=GISP4g3B+vYiB/8rtUDLQHU0qQKQXDbLR1wRlZns3NLV4aCPZun+Y8C2kY+Nu+tOYZPTLbhGUMIVFNHKXtfpcWgL9mX95Q7BgfBFrtgv10jjEvh1doIz4vFQRQAxDu/ldaJ80G1aNMovwTOg5XCiaOiiJDn6wCbRYCUBL/J1VZMxt1RqtxhtC1Z3g/VD0iGcNRxUCjT47+GPoya3mAT9/rPyIkEWkk8EwvmiydJuwh8YV2sG9/J5X26Sbb9RuugxECjKe6LKnwoReyZWzphfXdlrpxkHHL2Gydmm/vtGZ1Gwn6HKf3cis9BYiPNFkk20GwiJZPubqV5gdl8+TjH6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDJLVhriJK0wd7O5IVqub9YKvXpsgtg8XmSikMDJ06A=;
 b=rtcHiP/3aobaNBBHhp9ImBUol2UQF9bvZwxjXadhiq60EtcNeIlS0yfkjdpIkc5ZGj//PL+unCQ4xadkq3yErsOeSY2yR+gxdLNE0JQ8NTIRoF38YKa4tVn1/n70VbemgnFA1jRDaukelxnatr9KmwryhN9uykruvYKVBiSMfHffdBagD2mUhH73ub6EsUsBkIf/WqHqGvBDixNEiPhk0mvRKxH+386vQE5Cyw3fJzWHhTR/4UCznSdloduKIGa+iMunE1difs/Z3C0VCcgIENtsZT6yIuUp7IyS6wgB5eQ9Of59pvVFLUOwK43aKlpef+SNeZMZZ4ATvBxzSoFzQg==
Received: from BL1PR13CA0120.namprd13.prod.outlook.com (2603:10b6:208:2b9::35)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 09:21:02 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::6c) by BL1PR13CA0120.outlook.office365.com
 (2603:10b6:208:2b9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 09:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 09:21:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 02:20:45 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 02:20:40 -0700
References: <2e4d2f2b9efa7b0b32476947f63506cfe9568d1d.1778851656.git.petrm@nvidia.com>
 <2026061639-antennae-upstage-bd52@gregkh>
 <2026061610-lying-manor-2d57@gregkh> <871pe5i3v1.fsf@nvidia.com>
 <2026061754-patronage-wilt-e4fa@gregkh>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Petr Machata <petrm@nvidia.com>, Sasha Levin <sashal@kernel.org>,
	<stable@vger.kernel.org>, Wojtek Wasko <wwasko@nvidia.com>, Mahesh Bandewar
	<maheshb@google.com>, Shuah Khan <shuah@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 6.1.y] Revert "selftest/ptp: update ptp selftest to
 exercise the gettimex options"
Date: Mon, 22 Jun 2026 10:11:47 +0200
In-Reply-To: <2026061754-patronage-wilt-e4fa@gregkh>
Message-ID: <87h5mvhqxo.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: f5413708-44f8-4b85-bed5-08ded03f937a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	7B6kLeoGeL3ssl7UjviozGgpvac8yP7A27OzL49oHpT5DhbtCVUht3T+ykNYb2i0fhbn3A/hklfaeN52HXjsvF17F76IemT7/xE7vLXwUFmDNgsoLcrNKieAdmruo6VQ1DWEk21sCgEfsr9fbeBOfLdKetQfbi/mqlNS3XaY+btKELpUAmdrK9xoaFxZfkdV6yojlcT/4rMTD94Bbqu/X7vAZUO+cJevz4XcVBAklhSY8s9edYp1ch90iGA3/B04xLZaNe2a3+jKwZAz5/o0GeiDq/Ai3FgdyEILCseJ0AMfwihZLwftq/yV+XeNCUPey2upumQhAlLOqnk8jJIfflF0Mogf28oIiNuEy19MakmRNYnHyMbuRv4STIdML2qPZMUyiuW70X8ZkfAKhD2++DZsi2S5P2wglhlCBzxAG1U+GL5OsEisWzeD53n7lcF+HAZ2rhVrrfemwTbypO25wmz4pSeVAwKuV5aNAwu53NNxYpaBVbS3yzdsrBNFdsZ9LlPetszbKhmfCX/RrhzjnJS5MLCK6RE4h7P47g02nihT8PsGO8j77HO9H2K8oEF2k0PKe1LS0KvCE8o5b5o2cqZ7ahZSbn90BdQV13rzm5RS4FKuIE5HkKedNdEmU0QS18bmUcmT1QfFvRnE4PzbLku/zhNjunSBVxIGIul3Tqr2Y99WGMyztVXtLZbfXyx5wjZD3FcCDPCdREZDHd52KQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	494hmXeZy2bk/sifpvlWKpggmts924nhRcxiflvzWcxf/fLiEVHO5G0l8YX35Aha7OwE4QeJjajuYtNbJ4EO1fc7wvUHb46+3K226K5rJFhK2HyehZ7f6BaT2WzjHNzoSedRyfS+7KAZcRfHnMVCL7yCgLeKJ6C8L+gzu3QpCEbn8VK9koNM8OLhFVq01ZJdhZUnDbicY/ftkopaKISUnn1qjgJ/19JJxoSRPZ7s1tvUO0wHqozp+bvTYebdZ6ncPSY/hOTV36uiZ198xgt7XoXD0/j41qsIDsFXdh4KP6UZNPgb5JOmIVkcAkrYV06Kk4uvOd3hK35AOEEAEs5zpe6FcTWHAiY4+qa1W268/xf2SQiRvFBXpzc5kxYOIQo4ya0j+7i8TNulqttQIUwrDm2wH6CbefymfKk1v2R8vxT+DfhBbmx6zbd6YoXlxv0D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:21:00.7208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5413708-44f8-4b85-bed5-08ded03f937a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86


Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Jun 17, 2026 at 05:22:44PM +0200, Petr Machata wrote:
>> 
>> Greg KH <gregkh@linuxfoundation.org> writes:
>> 
>> > On Tue, Jun 16, 2026 at 06:58:53PM +0530, Greg KH wrote:
>> >> On Fri, May 15, 2026 at 03:53:53PM +0200, Petr Machata wrote:
>> >> > This reverts commit 06954f715deb0ed053f8bf85547370db6870225d, which is
>> >> > commit 3d07b691ee707c00afaf365440975e81bb96cd9b upstream.
>> >> > 
>> >> > The cited commit allows testptp to set a configurable clock_id. That is
>> >> > done via a PTP_SYS_OFFSET_EXTENDED ioctl call, whose argument is struct
>> >> > ptp_sys_offset_extended, where the clock_id is set. However, this Linux
>> >> > version does not support the ptp_sys_offset_extended.clockid field, and
>> >> > the test case cannot be built against this tree's own UAPI headers.
>> >> > 
>> >> > The reverted commit was introduced to resolve a missing dependency of
>> >> > commit c6dc458227a3 ("testptp: Add option to open PHC in readonly mode"),
>> >> > which is 76868642e427 upstream. My suspicion is that the only conflict
>> >> > between the two is the getopt string, and there is otherwise no direct
>> >> > dependency between the two.
>> >> > 
>> >> > This patch therefore reverts the cited commit, with hand-resolving the
>> >> > getopt string to include 'r' (as introduced by c6dc458227a3), but not
>> >> > 'y' (introduced by 06954f715deb).
>> >> > 
>> >> > Reported-by: Yong Wang <yongwang@nvidia.com>
>> >> > Signed-off-by: Petr Machata <petrm@nvidia.com>
>> >> > ---
>> >> > 
>> >> > Note: the issue appears to exist in 6.6, 6.12 and 6.18 as well.
>> >> >       Depending on your preference, I can prepare separate
>> >> >       patches for those branches as well. Let me know.
>> >> 
>> >> No need, I did it now for those branches too, thanks!
>> >
>> > Oops, nope, spoke too soon, 6.18.y still needs it, this one doesn't
>> > apply there.  Can you send that revert?
>> 
>> My bad, 6.18 does appear to have the field already.
>> In fact, looking at 6.12, I see it as well.
>
> So should this be dropped from 6.12?

Yes.

I was AFK Thu+Fri last week, and it's now out including the revert.
I'll send a revert revert.
