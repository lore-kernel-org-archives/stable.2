Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A8F29DB8F;
	Fri,  2 Oct 2026 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975611; cv=fail; b=K8IDIUtsn5UZC+1EWN/SMfJ7z8wc7oXJWzIhR6VcpTIxg1loyj4g0FZ1zeFnsFRMWdA8oqELwnEnuPjBRkStpk5JfwCWq5bgUJ71q6+ohKaabYW+orKi1oDGTAiGS5vvlV4lmdU3QNiyeM/3YgZ1NzrHfHNS5SZZ568bkINbsfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975611; c=relaxed/simple;
	bh=IKmnnWinaKDVIIBEDD/jzcBySRbhimTR7EpH4dERO50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JPzmM7uRWYD/Ji06TYyHe0/t34acM+5Y+KpOi4iV232JQNZMY/ACpnZy7GEu7JSTh3xFUeBJAlhKOrXixShc1FX8TKicAnmON9950QIn/URi5adX0nBxvnD5OatoEsO9/1Bs/GlVIWf3Tu5IinTOkB9Wcd089AmNAnGSpBbO80Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nU7+1zsM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gj1RdoEO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nU7+1zsM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gj1RdoEO"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692Ec1F83288013;
	Fri, 2 Oct 2026 21:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KeqJ03neGWpW1La3nhIjr7kB8CkqLW7PjlLqeIWFU7k=; b=
	nU7+1zsMjtepAOPzVi5Qe9gm9m58Zi1vz+hoNR4GghwxaoIpyc9u/OEJWO80mJvl
	w/v1tSClvbkmFGn9PJPE19lw7Wt+KF1/0KPuo+1OD6J5GfeZpeuxFIhDFshzSWhI
	9F3oq1ZzI5yKJhp3fRGblo94+wSNjta2/2uAJcHrefiRx78l4HL0rl+h2Dmek6wR
	B4eiBvqlmBnOODipEc73FnRVmNwxkO7j1LEMC55mjJ9LcqFt64FEQhWjzUARUNTL
	6WR9cYRzO+r+eu1eF+V4TxGlKH7C5ke2b1uN+gtXQsDufMYPrj9qFuRAEUiHTmTs
	g0f1U3TQITgxNRRpRDuXXQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns4m0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 21:13:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692L5bvM023091;
	Fri, 2 Oct 2026 21:13:07 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gu4adj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 02 Oct 2026 21:13:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYOeJksvwkDzgqNRrlj0wzVK1UuQfdEuPVDSeadP4rE+70UytC/gOIGd33ZOI8KbCEVCY7SjF3Yr8RnvhB7Ci+bKUv0iWdCJl+ha2LE1IoaDJCHTHWyXK5yYgSHV5xKzMkPbJxGTGGY41BdRxY7o9fL8zJ7etGY0VV/mRcbeWR0okccJfS2vmqttjrCe0Fv1tM6J7TSp/uPa3ulUUx2uurbEiOuJSZ/u3dzUM8NkhRtWFgoCgs8DGlmjxIUdvpdvluQy02eSms5Jpgo5kXgZQzUsEPbDBUICup1IPF/9qGHsVD05qYJjiGPQm4YPLcowrv4GRJJ3ICM5r93mi/jEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeqJ03neGWpW1La3nhIjr7kB8CkqLW7PjlLqeIWFU7k=;
 b=AzkF+2QwXh0A8mMPxMR6fRStwD6yDwRiH3UNPCfEZmHs1hOfx5MwdnvpZb2m/ZUD62zMCFPdrHp0nQEcaytGliVaSIcJADh6nD7i8o3w3ExYomCnB51hXnHcFCqbq2lAB9XZUwyDATNt7Rjq1GXIkiaI7rzTEcpRPxYCD21mA6Dy6OkHqPTcnGVudqBvgxNUfV4oHAl/trXL4qvjrbiKj9r8KbIfREDrltfLtHA4LbcZ8s4rE1AytxxztDv32nuc3rvCTvNL9h0LI2yPKCgEqyh1hNj/vLwkuAGtFiGu1KgfFvbs9XVxWWySc4iC2XdT2pqiroJi+nfZFSJjhIlpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeqJ03neGWpW1La3nhIjr7kB8CkqLW7PjlLqeIWFU7k=;
 b=Gj1RdoEOwlBAPPVNkpWdtpry4MEM85OWo3E/PiwQdxLXvIZF+iqRRuVjRmz2EQXt2GuglWwdPv3PQRZEMdo671PSvXyXJfGRoV15BSfvAFJ0hqXDLrJkuovmK8cdPeJOpPVTNTv17Br3stuxkeWZuNCNZZZf9IwvkaSHIIqBjYw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16)
 by CH3PR10MB7833.namprd10.prod.outlook.com (2603:10b6:610:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Fri, 2 Oct 2026
 21:13:02 +0000
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a]) by SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a%7]) with mapi id 15.21.0496.008; Fri, 2 Oct 2026
 21:13:01 +0000
Message-ID: <bf8ac5bb-91f0-410a-ac00-535a2d005e72@oracle.com>
Date: Sat, 3 Oct 2026 02:42:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] nvme-fabrics: use reserved tag for reg read/write
 command
To: Artem Dinaburg <artem@trailofbits.com>, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Chunguang Xu <chunguang.xu@shopee.com>,
        Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20261002204646.26451-1-artem@trailofbits.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
In-Reply-To: <20261002204646.26451-1-artem@trailofbits.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0301.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::13) To SJ0PR10MB5834.namprd10.prod.outlook.com
 (2603:10b6:a03:3ee::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5834:EE_|CH3PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: c45be75c-7197-4317-5c81-08df20c9f0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|22082099003|18002099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+lEwjcUS5gu7gbWXo0f+aEdFbaPTO7/8aDqfpnhWj/12Vv1tL2SCBIKuTIthq+RLRjLvZWj4IfRkVFhr+X7JbEZDfhk5bUtuUIZUXF/emtSLPOd06BlNNZBfi98Fj7LHkHScA0x1ZV7fLB8LDqByQC82Y9JlGglqYYAPAXa6eJn41wIJaImkwMxiIPD+3K5kcheLdPj3noxttYLJzx/3SHs0hl0S+4H6r/qQbWTR82JzX4RlSgkQl8aaQhe3KDEGyadHPk9NTeSI84XGC4R7fzAQaRiJybY5BJwqdUBPtCgSebZtt3H8kIlxxrCcw1UbNKWHvxo/3mTff7vgKsqyrfurLHt78i0lRVbn/IRigms3KRgjOXE2XyLlVUEKrZIMY3toTQ7NX/QrLJnrS9mQj+ZS5cNZt38mBgdqcBdUaySb5aodg+jzD+LcUDfuBWKRV5L/QCwfZg+ydigRE/BSItisQQmKq63LOrbxbB73hy2rumxK6yPQAt8x9sVMknQoU0RtCXxlnHrFlTP6wmau9PT1ZDYGNfusMUw9qhH4GvupHOclIQvYOVVRm9QdOw/VpT+DaMajtASeoRtDa5PBoP0WjCuZWeROV5TRXUD9sl8Un8W9OvuJZ+TSOpHDQDwGVQE7mpFjHaJcCUAwxJtivl4nbM4jJ3yeKLI/HbKQ0So=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5834.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXhlNmNqZGdPU1BnUmVYWCtxWGpHK0xqYWpqZGNNcmNKc0t4Rmo4c2J0V1BD?=
 =?utf-8?B?eklSQm9ySnV1TFI3TmNGc0hHc2tVb1VPZmRjYXY0Rm1CdllyR1JnZ2MyWUdz?=
 =?utf-8?B?ekg2eW9BV3Zkb1NDd0o2bk0rWmpFL24zcHIwTVVPQVQzeTg3SXI4N3FFZUh1?=
 =?utf-8?B?a0FJeVFPK3Vpanh2R0RiQ0Q2L1prRFV3UjFTR0w3NUQxSzlPRDNINC9jSEc5?=
 =?utf-8?B?RStiMDY1aC9IV1ZBZ0pxdTFubkFSek15aWpQTExsMWM2eW1hTDZ2OTJJQ0lN?=
 =?utf-8?B?UDRNc2Nqam1oc252cC9PN3d6anM5TlhndVV1MGxoc0ZSUkdpcjhDMWNrOFNI?=
 =?utf-8?B?Mm41SDhranB1cUV1c1ZLK3h5amlYMEN2bFdTL1B5SWJJcFFCaDBkemRQV3pr?=
 =?utf-8?B?WHlwbnhnVmgramNRb0JsSngrTHRNcjd2Q1ZoaFBKbFgvYkJjbElhL1F4SG91?=
 =?utf-8?B?WWF6SENRbjUvNlJtRUZKY1B1UGNGaEg2ZjlZNFRZQW4rNzBlSnowMGVjRlVw?=
 =?utf-8?B?VlNHQkFjZExOL05wRXNqNnFjNWNiK3dGRzRHQnRtUE1SbzdwS01wODFSSmlp?=
 =?utf-8?B?VkRwa3pYVTBnMFlKZ01SV0FsclcyQ3pEYkFLVUV1bVVtaGxucjBma0JFYzlu?=
 =?utf-8?B?NHA1emxnTXNPNTZvbnhaN0t1VnQ3Y2Y2Ym03WFBWL292L05qdTFkRE5IYjJV?=
 =?utf-8?B?MktUelFYWEpEU2ZtZ20xKzI0L29CZWJ5M1ZKbU4xYnhGZTREWGpFOEZaYjdk?=
 =?utf-8?B?WkpyRFN1TUJYSkFHVEU0amdqQ20yNklVdUFObThSRVdlT2RPWE9xOE1UVHBV?=
 =?utf-8?B?NmtqcVU0eUl4MTJMV2lMb1V0c04vSDR2ZVJ6MU1jeFpIMnQreFA4SmR1WlU4?=
 =?utf-8?B?V1VRT2VZQ0Q5bmE5OVZ4OHZWcTIxbDVSbmMzQURtN1FZc01rR3AwUzdlTVFz?=
 =?utf-8?B?Rlp1TFB2WERGdlE4Znp0clMySEV3QWFjbG0yZEp4UnpZT3pHSTB1ai80L3hD?=
 =?utf-8?B?a2ErbmFlT0RnaVAvZlZHUEVQaGZFK0tiakRSelBodVFBSGdCOWt5aGtSMjJi?=
 =?utf-8?B?Y05mZUFZb1A5T2RNQ3ZOdUw3bk1PdVpHem8vU3I1Q04vdXVrbnpzTnMxT1Rq?=
 =?utf-8?B?cVlITDJURUVEUS9lVW50RUtkU1daMTdQZHMzQWpRNFRKajZ0a01CK2JSVnZI?=
 =?utf-8?B?VTBtVklmZmhmSUZMVEVJZjVuWk1JUGU4b2NxeXlhYVVQZGZqZGNEYXhUWVlX?=
 =?utf-8?B?eWRSRHpGMG00NmpYclczSDZXclNxZTdLZjZsSExKNnh1a3I0enJLZ0ZUVHpo?=
 =?utf-8?B?dzBsQnJBd3ZRSVFobDFlNnplRzdsWGU4dVM1SE9wSytxRjR4dGdXbTdnSFhk?=
 =?utf-8?B?cWsyY3dRR2hJZzRxUVdFVkVXY0J4MDlTNFRNQ3ZYQVpoSjdLOXdtN25nMXF2?=
 =?utf-8?B?bm9kaUtwQzhObkVMTVVCcDZDSytGWHFtR3QzODliZWQ2VUorZnIwc2ltRkpO?=
 =?utf-8?B?bDlqR09ZanlCNndDWHFzb1I0OGVBUWpJamlLYkcvdTRmdGlxVGc5Zy92cnFy?=
 =?utf-8?B?SG5XV0lMNi85UkNNUVJDMVNjWGpLMk1nODFYTHF2M0pNTkFCd3M2Qjd6Vnc5?=
 =?utf-8?B?eHpNbWkzS1pOOFdHSm5HK3JaWjVod1VCYWhjL3haWEU5VTRyM3FYK0Uxa2I5?=
 =?utf-8?B?dHFwUUEwMllKVlhnRTY5MkpEMTdnS0krcjlGMmhOeWNjSUovUTlhZm43a05z?=
 =?utf-8?B?V3kyY3NrMHc4a2o4aXg0TEdLNEM4bUc0dHdOZUNXR0MydkpETURkZFlremEx?=
 =?utf-8?B?RktHdUdtYVZLamJhTkZFQmpmSWFVcE9xWjZJUmN3emdmczI0T1pyWjAwSGYv?=
 =?utf-8?B?dy9hSURNbXptMW9ncW9JRElSUHlzSy9BNVVYYVZtWkdwYlo1U00weHBiTE80?=
 =?utf-8?B?ZGpDclZUTFgwa3dpcnNxajh6UzZqeWh4M2dlcXFlVm95ZzFIMXl5ZVZkMWo2?=
 =?utf-8?B?K25nZ0ZPOUJnMjVMUzduVFRrT2tXQ2czMVZFVDcxVy8vMjlIRG5vWXN3OE4y?=
 =?utf-8?B?UUcwZ0NQN216dkgxMVI4bFJKZVJubWZuTzBEd0JWL3RuYm81a1kwMjJrVHFk?=
 =?utf-8?B?MVlkeFVYSi9uYi9xRXVvK2IzdE0rbm9GY2xQc3ZuZE9qMGp6N05NTmN3TnMz?=
 =?utf-8?B?Tnp5WVpNbk1rSnVsRWgwU3Ivb1l1dUQwTVdFaURPTXBlUmRrUnp6NHFMYmN4?=
 =?utf-8?B?eElDcWI2UnRNeldXOEpwUGtwalVOM0ZmZ0xyR1orVFZIYzNNWmxPQnRFVE9F?=
 =?utf-8?B?SVdtTW5PNUFVVytDMDVXemZDK09paUtzRW4vYU9yVUh5R1F6SGVTZ2dFZ293?=
 =?utf-8?Q?FdGoYeoC5B/U40ZuAEkgdXtCvfkVTk+WjZnF3?=
X-Exchange-RoutingPolicyChecked:
	Gscr0c3DsSb/2zx2DDoaa1OfUgjnNBb9evreLkJMdwpfm8N2XqYJUVTamqiiKfKMuOnQrmszaeheUQWRKQsKnxB/+TmsdKZodwtH/27ChGo+gx4dXb5OxnfMJD1T3LLMlbG1UA89zDXsCJYZq0aSBY+ntNSSH9mb2gGJBiJP89Yh5VlUpHMczKMwZUYgoV1MZtEjBchFRG/og5whTiw224JV67Jtj7qxqp8t6/336VLdDPvPr/EqTRONB8IK94GZWjOyV+hGbtyPaF33CeNPMszJc8YFfdtyhgmDILVrRM448/BiRSG74wlPhY9CBXuOeZryiQVMSsoK93D3KpZIbg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	33UTBGFihgHz9PL3ckqiSsgYISEVbBIyq3XUScV5WYlGrPrvsuN0e0S+2ZOLMonnK+MBk22DsBJnfHbwh7LyQqskHFSAuH5xSu1crUwjqGngjMvd9P2pM8ZgFDIK6RGfo4TXR/VjSPA7kmIPK8M4UN8yddAn394Hrriak4+goL+l7daN8GTbPyZWyaU+QJrAUCT3bi/MslkFMZ8zqrXkizFvkTO075YfdMd65L0z6Tb0wHH2l/Bw7wNQRkT8V/dWJjnweX0a3YNDBY0Xz0TwB6LJg24fRSjtTF4rqxHs8+BEto1FCqrXsJiZ47SPCDsWYRz4upS1cFxqA8M+PQoubs0WmcGRXMGkWdRMA+KYHAfVJDWSuZtByYGbbUfbWf35V91ZqM7qezm/ZoHKmfRsYXcUTrLls+WdzyVWOsc7Oo9DsytuAOhs5fbE33NPxfoQhAV1BHTiS5RF5ZePGX+MddjYVkgZlzMU5NU5KEbxbsVEZmACMBQGCLt2MwJlEmn9tSkrIjJG+dU3yO3aXgL51lHDMfu0ciyEr8s2Z7XK5MHwnpUOKPXdY8rRcXEzUvCntmWlM8w/OCJzFLSKH5ElTlckhEHDdXI4WHFUD38bizE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45be75c-7197-4317-5c81-08df20c9f0e6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5834.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 21:13:01.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyoVN4g+UkCwxJDGVIm0CC3gP+M7sHWta7uGbW1cDRVfIfyw3KS0xvVS7Lf/nDbCeMqwYE75BoFYha2AEjTK5I11TACWqHlw7ld0JlsO7cpmuxMiy+FPxmD6N+VwzJc6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_06,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610020084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4NCBTYWx0ZWRfX2NA5YqM2p9yS
 lAyZt1TX5njYtPniLP2fXEoy3tvUtdBiX/78yBK8amR0NRPEO7C1qqwmKnTTb+aHcyOfPl9wiYq
 KomdJ9H8Im9TuCmMv5QT/3srXc7cbqBUAh2waRRNa5ObC1IkLe7Xa+zCXPlNfhHkHlmD6NQJMY1
 BAIYxNF7YZ9tYcvuOiFrbefKPHSIDjDz/wNu3i3dGwKSytwF++kcC0o8D2F6VX1baan3CqolfFM
 Iern5EFw46dz5SJZ+lSmkk64ZJsrB6rils6VuM83MGxULsH4PGOqAHk0fyfP3mPXxmXot2V/mZx
 LTA7MEJNdBYZfZuCRe6WaI/1aKoSYegPvZzRDoxAlAH8uJUPEugzOh6Ev9ldwSE9lS50umZlQVI
 aMoeub37+kWYTOgLKvGrKWjg2lN6nQ6S57/06sY10fb3Sau7aGO/Cq8n2qTHQBIJBSdN2lHwoBi
 rgWAgnDJ1aCWvuJl2ljGwtXQnZguYnkzEtE58Qnw=
X-Proofpoint-GUID: R7HrS3TqHnW31ELvQxqQevyXkuGDOjiV
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6ac01e64 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=J2gJbEVsAAAA:8
 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=rP-kOlJ0AAAA:8 a=8JIV_2OXxlVeOeLDeyoA:9
 a=QEXdDO2ut3YA:10 a=Bt_igOxda4ASFyQEjNxY:22 a=A60uPr_FG5abr3nATN9e:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA4NCBTYWx0ZWRfXw6VBUc8e+LaH
 +lHgifrqwHaLPVqYKrwK7SsPPtxLScX4HiyEgTDCnHXLpxsM5HhwyBYbVmPfdztNM+HAOdMPdrP
 XEybiqM3jRRS3+FvDIigTASaN4nbiMKjtyR2XldFo4J1WeWKW4Zi
X-Proofpoint-ORIG-GUID: R7HrS3TqHnW31ELvQxqQevyXkuGDOjiV

Hi Artem,

On 03/10/26 2:16 am, Artem Dinaburg wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> [ Upstream commit 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa ]
> 
> In some scenarios, if too many commands are issued by nvme command in
> the same time by user tasks, this may exhaust all tags of admin_q. If
> a reset (nvme reset or IO timeout) occurs before these commands finish,
> reconnect routine may fail to update nvme regs due to insufficient tags,
> which will cause kernel hang forever. In order to workaround this issue,
> maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
> tags. This maybe safe for nvmf:
> 
> 1. For the disable ctrl path,  we will not issue connect command
> 2. For the enable ctrl / fw activate path, since connect and reg_xx()
>     are called serially.
> 
> So the reserved tags may still be enough while reg_xx() use reserved tags.
> 
> [ Backport to 6.1.y: used the older BLK_MQ_REQ_RESERVED request flag. ]
> 

^^ Usually this line goes after upstream commit message.

> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

--> Here.


thanks,
Harshit> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
> ---
> Hi Greg, Sasha, and nvme maintainers,
> 
> I am working through the small CVE backports still missing from 6.1.y.
> This one addresses CVE-2024-41082. It reserves a request tag for
> controller-register I/O during reconnect and reset.
> 
> The corresponding 6.6.y backport is already in the 6.6.y stable queue.
> The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
> in 6.1.y.
> The target-specific adjustment is recorded in the bracketed note above.
> 
> Could you please queue it for 6.1.y?
> 
> CVE: CVE-2024-41082
> Upstream: 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa
> 
> AI assistance: An LLM helped identify, adapt, and validate this backport; I
> reviewed the resulting code and validation evidence.
> 
> Thanks,
> Artem Dinaburg
> 
>   drivers/nvme/host/fabrics.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ffe433c4708941..2d0dace26d8f78 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -153,7 +153,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
>   	cmd.prop_get.offset = cpu_to_le32(off);
>   
>   	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
> -			NVME_QID_ANY, 0, 0);
> +			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
>   
>   	if (ret >= 0)
>   		*val = le64_to_cpu(res.u64);
> @@ -199,7 +199,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
>   	cmd.prop_get.offset = cpu_to_le32(off);
>   
>   	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
> -			NVME_QID_ANY, 0, 0);
> +			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
>   
>   	if (ret >= 0)
>   		*val = le64_to_cpu(res.u64);
> @@ -244,7 +244,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
>   	cmd.prop_set.value = cpu_to_le64(val);
>   
>   	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
> -			NVME_QID_ANY, 0, 0);
> +			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
>   	if (unlikely(ret))
>   		dev_err(ctrl->device,
>   			"Property Set error: %d, offset %#x\n",

