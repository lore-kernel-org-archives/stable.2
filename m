Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEE599A26
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891290; cv=fail; b=B2O53Yz3knlP9atslhgMDaSQ+hig4rhRtU4o9gNwe0+oRU/8WgWK+yLOmJE5p7E/8JO4J8VF0VcR+D91Vw+Y58r104rUkhprHpKSIzbcug+HsQw6ifX2veXO5GtINRPV4qHfETXF7GdZvCDWtIL/TX8hCAJYTf2d8eZhnBCyCOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891290; c=relaxed/simple;
	bh=Oi41WEf0xYc6RFfi8yqLRM3JMzkFUNPx6SDZUSkWWeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tYJHKS7x0Q9dnceb5spZTPbzEu2IBZwnGhtz5GJ+JVulvBp+F6u3lXNN5vPl47QGj3INhUyCHK14MS01/dK1Q2JH1uChuiwi9e9KOQFJAWanGw3bWzMDFvgdp0WR6cOvuzD+bvAF5hG53PZJrswfM0FuxHjbUEsSMxAHPuTCs/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ssThGMr6; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ssThGMr6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV3K4HpCaFxQ3qrsiekwkFj0+k+EkYvW0kbQAOvP+jGJ4l3U1ProS4+fF1CV6qYVqSGE2yTPxUEPX1hkzI8JQ5Y+Sm+SZLaMQcxhIcyrL0HtBtG4X2LeJKi8LvgcuFEqnMx5bgut5GYWQiOgeU1RbCZVODL6YnZR4yySIIHK8Z7W/vfwJonVy2nsLZaImOUNWa2GVeXcMoyExyiOpps5SnRbR+3svj5a3ghSzeTmFWmfPZAnJbYJghOcOD9kJYt9okQWrczMbGc9+C/TwcJKrnK/qIRpK1oew679p9RdPDLCJwTDTt0b9atbBW5K3fGrmmE9MVtTqe7St1atqocc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbKJtKBLG/IS1oeALfitw4YZeO5XN0sgqKtn67x9hPE=;
 b=gVqXlbWiNAFIIMW57RkaMf/NEHin9y5AqT5Lsb3f/dXnBduOoyU9LO5dmOXZm+UOZgWuRrlHSI+/SgWsexNfumkNuTTMIhk6haKXT0cGzDbc/1XgS86nkNAh7u7oRc4/pcd2Z9z5GjW9vEe2Grje7xfJlc2Ck3z889WsGRsbS/3CxUeIV4a4ZOysusUb0eri8E4fNmDxVjbkRzsmOOErQhpffW9wpAf+Q3h+PQ06TACHEtO2XfWSFUCoobLDej88SIhDsNo/XqsDIGwmeCbFo4VX27IJladBr8MgDN/1eaO8RdDRVWY/lvrYSsccpA7ls31VLlvKQnCBheUVxUJpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbKJtKBLG/IS1oeALfitw4YZeO5XN0sgqKtn67x9hPE=;
 b=ssThGMr6tFmYbO0dEcFqRUhnEEihzGJNXmH7Yz8s5wKgd/xInN7lRsLE0LDOgSTyCCn4okN5x1+Lb/WdfbCPlj7pas0Gp0Wrc5An3VdNiRwvXUhEQ9CJ5A3rtKcLNq50FQbjswukxNCwBf1CHbQ36Iz7YFbbkHp1OxbnAaYaYfE=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by IA0PR12MB9048.namprd12.prod.outlook.com
 (2603:10b6:208:408::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 18:14:41 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 18:14:41 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Mauricio Bellon <mauriciobellon@gmail.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lin, Wayne" <Wayne.Lin@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, Mauricio Bellon <mbellon@lenovo.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
Thread-Topic: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
Thread-Index: AQHdNVjsBEnDHhjZq0+GmN1h0gU4krbFDgaA
Date: Tue, 8 Sep 2026 18:14:41 +0000
Message-ID:
 <CHXPR12MB99922037436C4ADE71BA82E152E5B12@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
 <20260825211819.100210-3-mauriciobellon@gmail.com>
In-Reply-To: <20260825211819.100210-3-mauriciobellon@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-08T18:03:32.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|IA0PR12MB9048:EE_
x-ms-office365-filtering-correlation-id: b9636c74-d46c-4c35-e40a-08df0dd50da3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 4/jxYJNfvJIQ9Etc+SGOoxR+g783i3h8Fbk1sFjbw7isMNdjds7gowcN86ZBWwiNFbagRf646rsmiVsXBstAEWFq71dJbPEnbQrSI8+h2j5OVeKCxvqO90k1t0gBJ5wcQctb0pNIz+dRQiaf8Mnaw2Ca+hKvU4sNqLsTSShfV3cInNTf7RD01W5ELWS5CT7bQ5nh678MZaCP6FohYeQuMjjdvfRWkR7V4hoqXfBbCPTB7Xuu1DghUebHLDsNwBFkMjpJhEjt3+y2jVywYyJkBAEgT6ioRdfxqwAMGnPW/YiN8GUdnUQxB4A1VYpaxIjPxyd1a4RDVGAO7pEvhzVZZWeHpAEV17m2QILvdi1d70Ua1aNMEm4XY9LUBhI3OQK18z22uWXRZ4K8TJYtaTbLcRO1nDVy5OGoDOEue6jzCkUZN7YL01mHtYZkCoQmkPz/9mMJNx+7jG6MqFfYs9upmQH4nPJX2yR+1TE8jlTFfs+f19q9HlZ+9oUVlYu5dUypgWc6an1HDiUfYi+ek5LxwQK/i1qSeBpa9PEo9EkxrIf0rFKlVBQBkd4mPr7xTqI+cDzgRs1y8RMa5cwEVjfeayLdSoAPRom008WcUNsRHufZMOQu5pmBcyUiZ6ZtEZdkmV1aMe2UjAv+/QkIyuMrhXwfahs2HfFs0hEXp47hFKpuvZZTLIuV9GAiSmil4Pz001nq7D+ZdPyEpr6hqPs7Iaty0leXTzf/ROoT9RNmcXo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHXPR12MB999220.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pkFS+L9KEK0RnXmZcJ02RbslrKln2VM59Zi1iPSFybgMTuBWEfjBGPTXuEwn?=
 =?us-ascii?Q?QK5da0/788R4BWzDazGo/ZdTG80LQXAXpWDSPB8ilhGYXnfeEjuCh3syZ/cY?=
 =?us-ascii?Q?2X6Qm0SxqE0ZdIXH+1SOO2zInqtZ9oAEYQcCqprcEU6V2fZuzU0Hc30CO6wY?=
 =?us-ascii?Q?Td7eF6k7k1IjEm54tXPYezVxCLx2SFIEPolKnv6EDeuRZcmENl8ev5NZD/7L?=
 =?us-ascii?Q?W+Z8QB2xe802Y+c5Be7PfHKYAwKYn7gcCSzJx7juF0EyeGh3F+qQbE6VHG5S?=
 =?us-ascii?Q?wxfl/Mw5Gst6nkPhErita8dBezwPNfiuCOhG7ORFZPR3+NETEAx6XP/NvQ82?=
 =?us-ascii?Q?aO7O6Snt7wmNZEgbLyodHyS1NZsFJDvtcCJDdg1S8gLMStk9HbcP9tSl1spL?=
 =?us-ascii?Q?0arlWC2gaTYnepvvDeabdnC/nyEXGMl1MU8tY53tZ3maOXAnTVu4R96dLlzk?=
 =?us-ascii?Q?4axjmxAr1RQ2qswnIM5pD4g4pk5PzY3USuFbcz3368uqSdB2iAV8AFM2Nh1T?=
 =?us-ascii?Q?quT/fB7yfwVO5mpEFblnL0hGEyxxoz/nwRUfYaJmW22nCdLdXYpIS/Mhi0QE?=
 =?us-ascii?Q?jE/YEAnkU5IVDZkGTgHV4Ap7Czb57q/O9KRK8Epv0aXMxG9yv1jhhM+oO3hG?=
 =?us-ascii?Q?VqHkTGSDPkhj5s9vFOg9s9HD5xR5HED86nCcUcJojUvhqf3rz2yTz2bGuoya?=
 =?us-ascii?Q?KLUwaJIyeslAxyvCebTgZU2qaBkZfaTExmtQ5Se2YkYcNy7o6s/HFNohmEdc?=
 =?us-ascii?Q?hlUXGbP/IFugyKR1V9beVNfSPZycmjkqlKtKUKENEmCLplQS0itNUnDBPHtr?=
 =?us-ascii?Q?LNaCY3StjYFH1cb7h62JP6m1wL9BNbYmGGxRallgBGrtF9lq19P+o7ifwEea?=
 =?us-ascii?Q?IPlfQvYLEvQNgPq3O6zRHrXFGXy9sVz/BAnyHYc1sHnsC1AUcicBHH4GEONB?=
 =?us-ascii?Q?Miq8iOPL9HIqXrWNjNSEaOwuY0FmuqLINerDTM0EL3n/3VVhi2AwRh6c/IJt?=
 =?us-ascii?Q?wjSrvd/WlJ94RxIHwCnHLSbzqe3Yj7quOx8PId8h8s4553oxFU8oToRGl3gF?=
 =?us-ascii?Q?6r8MbzSMeUTyuf0ZxwTi8VxcmN8tAWTXq2edZhfbNzSlfXAbfqRZZQQaHD/4?=
 =?us-ascii?Q?DGzEH+/3JqjHw7+h0ejHxWCjmIyM3+79r/B8pwvFJQOLb5hLJxLIciEinA6a?=
 =?us-ascii?Q?O8yrCfIYGV0cdSm/TROWCPsaaU7rgULe5DQVxKW/12rwNzevvvFQKNdW/IcF?=
 =?us-ascii?Q?i5FpXvjS6hEN2kKrzm/TISiXQH/jyJssucbnqpjJkPjeNk/ChNPdvKjtAyei?=
 =?us-ascii?Q?9UxMKIws9VcmGHWWw4tkkvWOVEvjeBIKpMquGV1PEpEKK/GI3M4yhA5WbfSZ?=
 =?us-ascii?Q?Yf63M+KvCrJKc+I7pZBrJeWBS6DQf9RPjA7icU7b5NHx3m9Qs2mbv1yuaoKP?=
 =?us-ascii?Q?AAE28nlXZvGCdq2kLIgJ/cb4iWAguPzbBcSLzzZBhlxUaj3y3jBFuWGXss+q?=
 =?us-ascii?Q?y7P0rG5dFvJnFU6ncWc4O7EAzCh8UODcrxrinnMAER2tFRdEbD+XGAztvP7K?=
 =?us-ascii?Q?nTzOUsgbvIqXa8Np1vdTGJu2H85hlmK2gCo/VbO+srkG8izrSsackdAt2rap?=
 =?us-ascii?Q?9vUZloO3seNfwgyEwvAwsw4QQO1jdZf88IwRbcE7wupRuaN5HjxuHVgzazV5?=
 =?us-ascii?Q?9vDKM2SiNB2UX3v6F9t243B7HWEPQck0UfcC8dhqtjwf4e5W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9636c74-d46c-4c35-e40a-08df0dd50da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:14:41.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1AlD4pAgjaZhM9tivWutSJmXpJX6EcWvhKXO8hpgvN3Pmjb1HCDzUT/BfPjm+Pw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048

AMD General

Hi Mauricio:

     This change breaks dsc, causing black screen.

     Sink RX dsc enable should land after link training. Writing dsc enable=
 to the RX on an untrained link is too early, that should be done after tra=
ining. That is likely to be the main sequence regression.

Regards,
Jerry

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mauricio Bellon
> Sent: Tuesday, August 25, 2026 17:18
> To: amd-gfx@lists.freedesktop.org
> Cc: Lin, Wayne <Wayne.Lin@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Mauricio Bellon <mbellon@lenovo.com>;
> Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; stable@vger.kernel.org
> Subject: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
>
> [Some people who received this message don't often get email from
> mauriciobellon@gmail.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Mauricio Bellon <mbellon@lenovo.com>
>
> Direct DisplayPort high-refresh modes using DSC and two-way ODM can
> commit without visible output during a 4K120-to-4K144 transition. A worki=
ng
> 4K144 stream can also return black after long-pulse hotplug reconstructio=
n.
>
> The DPMS-on path currently enables source DSC before link enablement but
> does not enable sink DSC until after the source stream is enabled. This l=
eaves
> the sink and source compression state ordered differently while the strea=
m is
> brought up.
>
> Enable sink DSC immediately before source DSC in the pre-enable phase, an=
d
> remove the later redundant sink-enable operation near PPS packet
> programming. This establishes the order as sink DSC, source DSC, stream
> enablement, and PPS before the compressed stream becomes visible.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 48b086d15..412ce52b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -2635,8 +2635,10 @@ static enum dc_status
> link_set_dpms_on_pre_enable_link(
>          */
>         if (stream->timing.flags.DSC) {
>                 if (dc_is_dp_signal(stream->signal) ||
> -                       dc_is_virtual_signal(stream->signal))
> +                       dc_is_virtual_signal(stream->signal)) {
> +                       dp_set_dsc_on_rx(pipe_ctx, true);
>                         link_set_dsc_enable(pipe_ctx, true);
> +               }
>         }
>
>         if (link->replay_settings.config.replay_supported
> && !dc_is_embedded_signal(link->connector_signal))
> @@ -2729,7 +2731,6 @@ static enum dc_status
> link_set_dpms_on_post_enable_link(
>         if (stream->timing.flags.DSC) {
>                 if (dc_is_dp_signal(stream->signal) ||
>                                 dc_is_virtual_signal(stream->signal)) {
> -                       dp_set_dsc_on_rx(pipe_ctx, true);
>                         link_set_dsc_pps_packet(pipe_ctx, true, true);
>                 }
>         }
> --
> 2.53.0

