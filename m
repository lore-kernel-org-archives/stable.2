Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010013.outbound.protection.outlook.com [52.103.73.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8667391E58;
	Thu,  4 Jun 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558657; cv=fail; b=cDUOcmvVKedVfwBTAMQ0N+uuKORf5QikMcdccIAkXtshRou5Xz4eCYsAYJasA1yEBzwBp04arGtCZJqYjfIU/v4mZl5mev63YTPlLVayZPigepmCNlpVK/Kp1gZM0zdsAAkQBNJi4GRL3BDvAPz1WuJ3a5W96fX+YKVTtkiBogg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558657; c=relaxed/simple;
	bh=k2UIIoa/laWGRzbLlx/tHTFD00V2KOKLtB3Ao8p7hH8=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=JVZSdPw5xoxv+5leWB01gJ5GkfJNVi51EOoiZcI5hCbj8Ij4D0X7X9TCjBZtkKI0UlPM1EeIFYaKohWwnQBPlcUVw+ecwMCBDG4jdik6LkwESYy/xo3KRnldvgi71c4ofmtbgBMEFXu/M/oxHqmMKU20LuzPxUagY9ihvtijomg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bRNbrA2k; arc=fail smtp.client-ip=52.103.73.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bRNbrA2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou++MIf0Spu1U4FPyWVzbm/1217c3wjSY3sq5XSLyd2C+qEPukkQCdezJKTVhoAxd6EWBvOUa+rb4AkndEXwnLafkLyK9rmBlbPNuDElzCjgIMxVLRqhE2DwK01MzABY42A1qNhvf13Py5e+ZKgWQgLGQhSS0d2o3jNwuifce8/EolQXXS90Wiuw5+HEgYrthsfN2fHxjWNcpYniTej2Tr0+4sZyJ+l0yco9dRWRZ8KYT9AlnvLPUS7W8QFKnJc6bZk8py0iQNrgDJsYRd5dTFMrdFZV+9wSLsOcme1X93meo0KiDNxbKcamfCEzziXuQsH39nq9BbK/m5n34uuS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3+5Uv5u0H/EavKhY3gsPxJ78xqOBY8/8wHkBYSLEqY=;
 b=bIkpkc+G5eHLY6hR4oUaiBJmY4jtL/wzyOWq+l6gKdd5P0+B2w4gyjM5P9e6CgGYf6Vz2Qnyemm+ZBtnGkhftsErhKgQaXWxZetmKE8oY7Lo6cj9ibo6UdzJCuUJh38eBB42NTTYVUS5D4a4dj0DkB9KhZX4oRDtNYbAig78G4gAGTEgsFwuin4QLynib2smWayRh7XlUo6IP5Jdznc7fLeFKM5jVM4AUWAnftXmZC8hteDvkeR7Wwknry0h5Nmt+FaLNgHpvI0G5gGg1Tz4z+0IJTWJxPobTlA82E5AiYG/VoyaN9lPmfRJccSGz2haH9a12ixGPCQfCkjggGU/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3+5Uv5u0H/EavKhY3gsPxJ78xqOBY8/8wHkBYSLEqY=;
 b=bRNbrA2kV6KPLxn7rePHgQ2Zwbo0TAoYvyxBvv/zz7BnGAQdJdohfTuG2SKabSMX4Kl3Cp2LZXd4FGcMKFP0xbi4tGQSh5nphbmmY7I+0p0WkrY6TJ6Pw/bFyEaqljUiHpiqs263p95l5pBPm4jNgZMa1v+sF8znWqAWARdO7bGOhFk+AfdH3Cj0qpM08Uo3iCjgXliF+0fEXziNAqu9wzXTmly21gRBEc7mzhskUx0doYi1f2bioCE9vi8kX23oYjvQTG49ZFc2ValRTs8gsbmvqOipHx8sw6mp+XDQahvBOexjKRX+ju0eIcV/cCO5idetn1s9WAgBtj6ZSNStAg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB8986.ausprd01.prod.outlook.com (2603:10c6:10:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 07:37:30 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 07:37:29 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 04 Jun 2026 15:34:25 +0800
Subject: [PATCH] coresight: ultrasoc-smb: Fix OOB write in
 smb_sync_perf_buffer()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB788156B3380A36835DB22290AF102@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAIAqIWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMT3bTMitRi3dSUZFNjM8tEi8TkRCWg2oKiVLAEUGl0bG0tALfbNxp
 XAAAA
X-Change-ID: 20260604-fixes-edc5369a8aca
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Qi Liu <liuqi115@huawei.com>, Junhao He <hejunhao3@huawei.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=k2UIIoa/laWGRzbLlx/tHTFD00V2KOKLtB3Ao8p7hH8=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLEWtht96ql6Wy37mzHigWcOy/aJj2qNFtpuPXtW+M
 Pf5FPPW+xs7SlkYxLgYZMUUWY4XXPpm4btFd4vPlmSYOaxMIEMYuDgFYCKt9gz/LJbNZpvz0lN8
 R0DdrFvfg1YkJkkn8O18vmvFpJVWIbt6pRgZ1msFG+/hCuPR45gjNi2z4lmU9tUntYetv94+r7a
 n2W8WFwDXHkq6
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:405:1::26) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260604-fixes-v1-1-ba7ac2101fa6@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY0PR01MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f43162f-3a15-4470-2111-08dec20c213c
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOL5GJyS80o6UroEiW/CEUgDnoH7ETGhqJzzQDemLXDENsmWjm1wBafGpcLwDuM8KCCMG9DOyB1WdN520pFBb1WqRGhG83Z/AiJyWlenr2vNQnN4SxetR3su6VJHvlIPNm+QB5Hn5NRZxOdisBUvU66enwRShMm6HRjZZ3ye7MovaUhDRFgrW6dt1j9l2WcyUidg+hx+QeJUMbqQQLjgA2vqttRP/GxIc5WPvDyHQfdz0wMa7Y8W5CKUZVc5DZYAfgd/SJ2Xvf91E3N3BOk8mngewRsxcPdXJ0aQUs4sRS0EJWGKpHo3ilpxTxKxTZn3JuJvVJ0JhIeMrTEqLNqU2V5rt4UVFKlFTywIugcibu4Ngkvntcy1U5TsSEpqiu2zbtGy5IdknCvWz2c7qGqUVkrHFay9+EhI+eKdnbFMVzjhGEp6wV5qPwHAXB3snqwGW01mzL+lQXXos8SnmLqDTi8m5YFQLQSkalAuti2gIoaXMWS9yWwsdGv1c2k63yK0AiJUjPfbrxPXZmKjxz+BmKRXl5hMg8IXuCqjY6FsmT66Q9eCci9gJuEe41h0cmr+jo18IiemOhoOFSTANNNK1icP8sVAfD/+26wLD9c/c/TAseGmOSGKq2o1juVWD8ddss6vDHxvTutWze/aOZAHP0TUkM+xFzPewIYgA6D6bkPmzQ6iU25R577fIJRIzXy5KfurKAL+gwGT/3KJdrzucrvQYX46AAWs5uWXI/FB7bml0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|23021999003|19110799012|24021099003|5072599009|5062599005|6090799003|22091999003|24121999003|55001999006|440099028|3412199025|26121999007|40105399003|53005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU9IV2UyN1ZjSXZReHhhM1E2dzhoOFFnaVFWTFk4ZmxrUkFoaVg1SGhmMyt0?=
 =?utf-8?B?NnovMWVnZmw3OWVpNEdMV3YrMkpiSnl6NVVUbEptL0ZNeFJBcU1RNDV0S3FJ?=
 =?utf-8?B?am16Z0FyQVlLSFM0UnB5bExjaWZ5YkFPWWZWOFIvdnhqdU9XTVgwOGFkRVZM?=
 =?utf-8?B?OFBoNm1RUWxCVlZTZzI5Vk84NGtORVdBcWwxaStpK2U5b2RwVVB4SmVKdEUw?=
 =?utf-8?B?MkZHWDVtc01xRG9NTFJLNnViMnZiYlVGK282SWZYMVkxMEdOTTNJRFA0SXd6?=
 =?utf-8?B?d09NSUttanI0a2pvbk1RdWFmcFRrM0k3TEJBSXZXcnM4TE9PZzY0Y0MrUExy?=
 =?utf-8?B?dkFuL2tkMUJXdXNCK2xLaGdiOWxwR0cwYjlyR0Z0WktWQnQvTUFMQkZYQmhk?=
 =?utf-8?B?cTdnMmhwM2I1Y2VvNHhkZVJxNEs1b3F3dVpFVlEzTU50OFIySjBFdjV0NzNL?=
 =?utf-8?B?elRNalMxSXI2Y0FYY01STHJIaTA0N3EzUjR3bmhhTUZ6cnlYaEpZdndnNS94?=
 =?utf-8?B?QlBRVmkyVHNZWlBSYmVUY2NHa3lNaDVSeHBoVHVUMng2N2ZqT2JtekljaTJQ?=
 =?utf-8?B?NytkTjZ4R1U4NjhiMm5pbm1EQm5qbTJLUFdNbXdqSXdQa05PWVVNbzNGOGRV?=
 =?utf-8?B?SWQ2YkxVdjFnaWVKNmpkZVVRbTFHWkJhb0REZzM5VVNFbTVOdmg4dlpjYTFX?=
 =?utf-8?B?Qk8rM1R5ZDBNakgyMFdPeHh0YlZnMkg1dTJwMHV2alVNbTNKa0pyV21yT3NK?=
 =?utf-8?B?SU5Md05BeER0OXB0Mm5pdkpTVmppUzVRM2UwbkJ1dkZKSGRNbmN4SWFHUGhW?=
 =?utf-8?B?M0lJSnNVVGphSC9DaUtOOGc1R29rMitLS3RxbzFmSldnWkhHSWJXK3FSZ0ow?=
 =?utf-8?B?MEt0WkJzTFVNd3BHKy8xVllDWkRBbUxXYWt2RTNYWjQrL2ZYZmJHRjlBcFR0?=
 =?utf-8?B?VnNhUkFpVkhjcVVOVXBBN3ZiaEdud0YxV0FKdWRZekYweXROQmtvZmE1enNa?=
 =?utf-8?B?dWFkR1ozcVMwN2hHQkM2Z21IYVM1RDhjOHIvNHBzMEZTc2dzSE1PYXkyMlpZ?=
 =?utf-8?B?bzFod2hGdDBkcDBLd1p2Y1JCbTVsSUpWTEUzd3pNY2Y4U2ljbGVnT1NlQTVV?=
 =?utf-8?B?VkdveFN4MHlVUXh1bTRFamVtR2hOWjhhaEtHVzBVdTJkSXBZbmY0V2ZNYWlE?=
 =?utf-8?B?dFk4TmNoOTRCN2hUenMzRlYzTjY4bWhFSTQ5cHB4bm10VGR6UXdUV2loZW8x?=
 =?utf-8?B?MWh1V0twU1JQcDNibmsrUHBucVhJcUhTUytoeXhiOGZqVjhJMVM3ZCt3T0Iz?=
 =?utf-8?B?WUMwTVRsTTVRVU9QL3NUK1Robis1Y0dEaElZcmE2TlJLT05YajZlaWJBNlhh?=
 =?utf-8?B?R3RxdU5LQUNta3BhNGtjODBPVUVWWnEzYzJvcm1mYkd6YmlKc2UvT3NiWjlm?=
 =?utf-8?B?bzA5bThvNjlsOFdSUzdTd1JhT2VwSUhLajFCR2Q5NjI1eDdtK1FkeFFLcDE5?=
 =?utf-8?B?SkM1T1ZGUDBya1FtYWhKNCt5SVZ6Tno2TSs1Q3lacUM4Qzl3cE11RDFZWTk4?=
 =?utf-8?B?NzRYdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzI4aWY4OGFrNTdUSkpNbVdzR1NBRFczVkduRXpTTHROaXl0Y1pvOVM3Vlcx?=
 =?utf-8?B?aURrakhaWGZ0TVVyVWR6WFdoQ0NvRkZBNktrd0xmWDBwbkJVZThVTHNyZGt1?=
 =?utf-8?B?ZjJzMVpQUi9oMCt6eENBU3pQUFhLRWRNQk9rWnpFNVRBTGxjcXFCamlYc2cw?=
 =?utf-8?B?UnFnYUdVRmZ3RkVIelRILzRHSzZWNkpKSGp5VkFmUTE5YXBhTER5bFQvbGx6?=
 =?utf-8?B?TUFCRitqckIzQjkrYXB5TTU1dDI0NWNnc2xLMW5KbXo4VG9DZmZRTDJ5NlVU?=
 =?utf-8?B?d08xY2JyWjJrMlRya0QwNUcxd3I2K0xnNEJ3Z2NzOVE4b0l6SHZURzRISFM3?=
 =?utf-8?B?MENZb3ZVV3BhbUxwN0hoa0VVOHhIc014a3F3NUxhWCt1SGlqTDlPVGNHaU1j?=
 =?utf-8?B?Ky9FanFoUzJuM0FCQ2pEM3cxRURiYzZEb3BhdnplRVJtc0xaVHFIdVlDbEVw?=
 =?utf-8?B?MnFYRktFUHoyQXJJMWgxSFgvWG1zZU0rUGE1VDZBd3RtNTNwazJZOStqOTEy?=
 =?utf-8?B?SmRWODEwenZ5YVN3NDcrN1g3b0FUWkovL0I3Q3Fmd0V5S0xrWWxaQmxkMzV2?=
 =?utf-8?B?bzBxdGIvMTNLcm1nd1F2eWovQklZTkU5UkxNTDRTNTF6WWFQb0ZTcmdvZmJw?=
 =?utf-8?B?STYvNXhMUnVDVkNBblhMdm5lZzNNcFFqVUxpa29uUmxWMW9nSjN5UTIvcFpu?=
 =?utf-8?B?S1ZVcysrZmtlWDd2bjhEZi9ZVjJCL0xMeXQ3V2FTd1U2NFpORHhrUVZ6cnEy?=
 =?utf-8?B?bTluVTN2YVZWN0pUWGdua3FDSUFNK3ZteWV4V1NUM2M5OCsvOFUvbDZVcE5y?=
 =?utf-8?B?Sm4zU0xtbGk5NWxMUFVhRXQwSGNUcWZyNEJwKzlNQjJTZlFwSFAzSndkYTl3?=
 =?utf-8?B?azV3a3JLMDFRcmpyWmpyY3hFVEl3UE9ObHE1UTJYYkZsM254UExtOHFhMjRt?=
 =?utf-8?B?M1VmZTQ1a2ZsRHlzZmx4dFNYVWkxOUY1Ukw4R2hoQlpWYmUxNHJMU3ZwbUlL?=
 =?utf-8?B?WUsvYnZNakFySDZkaEhEa2pia2FQL3I0cE5iVFMzR2hJeEFtR1dvZW4rc2Ra?=
 =?utf-8?B?V3JpeG9SWWdBTGRCc1pIYzhKMERQZUFYN200K2MwMXRYUnNKUlJxczFvc3hK?=
 =?utf-8?B?TktRdFlDS0NPbUwyT0ZMbzVWN1FIMTF1ckNWRE52aVhJUTdjdncza1AzTXpR?=
 =?utf-8?B?VE9Lb0sxQWY4MWU5YU1BRGtxMWRTQ0xMRXJiZkVXVHBsMmR2ZHlFZ0k1bDEw?=
 =?utf-8?B?cjBHZndjcDhMK2cyb3lydWNBemhyenAvQkt6ZHUyTjRUS0tXMzRsb3c5OGVi?=
 =?utf-8?B?cDRHVTNRME13ZmlkeExDNVBsVWxzWURIY1ZoYjVtRnN1UDVqVEFvK0RML0cv?=
 =?utf-8?B?d1lxd2s3QzN5U0FEOU9Za2dpNS9wNmxYZzluenREczduakliZGlHcGpHaU5n?=
 =?utf-8?B?am5yTEFlc0p3RWFEQjhTZm9GeGxhdDU5N0hTUk5pc2l0SG1XZHVDTEtIeGpH?=
 =?utf-8?B?ZWhKVTkvWHhWUERWelg4clZuTThEWFJ1VmovL0hxUGRuSFlhRWYzTFF4TGhi?=
 =?utf-8?B?TkVrcFVpTGVyaER5YUFLNDAyUENta3p0Vkg1WHgyb0V4cXBxSWp0Nk1oRGM2?=
 =?utf-8?B?bHUyVUhrcTArWDAxM3hsV2VLSEg5V0VHVlcvU1gyTm9RS0svS3VLWEVWU2tD?=
 =?utf-8?B?TWVzRks5R2RDSW1ZeHhPZmV6WDY5VnhUUVJYTElDV1dKWTNYRmRrOUI5NWhF?=
 =?utf-8?B?bkJhNHRaSVBCNkZsOTZUemtRNHUyTk9SVnFDS3IvbHJZa2E4VUZOTFFoRjFy?=
 =?utf-8?B?ZFhacVBTblEycGJLMytNYW5sazcvYVNsYjQreHlidWpjS2cxWjdUZU1wWlFD?=
 =?utf-8?B?aVlpQlV6UnZTenJBd0JJeTFRSHJLcEFMdjJ4aDhwZU1ZYmc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f43162f-3a15-4470-2111-08dec20c213c
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 07:37:28.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB8986

When the SMB sink is used as a perf AUX sink, smb_update_buffer() calls
smb_sync_perf_buffer() to copy hardware trace data into the perf AUX ring
buffer pages. It derives pg_idx = head >> PAGE_SHIFT from @head, which is
handle->head, and indexes dst_pages[pg_idx]. The pg_idx %= nr_pages
normalization is only applied after the first loop iteration.

This leaves the initial page index underived from the buffer size, which
can result in an out-of-bounds write past dst_pages[] when head exceeds
the AUX buffer size.

Normalize head modulo the AUX buffer size before deriving the page index
and offset, mirroring tmc_etr_sync_perf_buffer().

Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/hwtracing/coresight/ultrasoc-smb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 5776f63468fa..20a950b9dd4f 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -337,6 +337,7 @@ static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
 	unsigned long to_copy;
 	long pg_idx, pg_offset;
 
+	head %= (unsigned long)buf->nr_pages << PAGE_SHIFT;
 	pg_idx = head >> PAGE_SHIFT;
 	pg_offset = head & (PAGE_SIZE - 1);
 

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260604-fixes-edc5369a8aca

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

