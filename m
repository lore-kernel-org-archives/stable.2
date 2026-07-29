Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A9426431;
	Wed, 29 Jul 2026 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310831; cv=fail; b=T/QiPLiaLuhgTYkSkLQgDulFOAPTvseSyX7OPQybQnM2TaG0JrTnHI3O9/p3dbsn+RzZjpbLOmtw3QmykMzWSgsDVvb5N8FaXzg3y8TIn8nCu/L7Xhe+LQqn+VPqQl2qTH9TMxnj90g+Ky5jWRtm5XVM28zGYms1QG6VSHeS5nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310831; c=relaxed/simple;
	bh=cI/cItK1xNfYX8FJz3RT3JkSPMV3ve7yEKsmtta3vL8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sqO3AkDAwXei+eiVypMjgZRAkfBpF/sgBKZ9p1em8oTUIaEAfvVhZ42sasasjIXVq+JX9bhJX4meqNQiWpaS7FlcbO/P7M+fCA0tslqjUzIRmH7dghpy5hjAmleX1AjRGTsRHHusyERBEgp7O0F8JjJUuN0x9tTxYTPJSa7NjHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SdoKzoCH; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SdoKzoCH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDbABgtO6VlQ1yhPMqnYp+/wktIH5+nya9z9ynSw8IVFqrKCnWM9DzyFmK0Ovsb/TnClwWH3nugbYkTn919qZd4sf3YSRt8SkkxI3m6nv0YdBLTEr/1+QMIfDZ0YCTcWQHyDIxd65HGHh60QwnPonzCtZxYaHVic1JnRoJ40zOXt2n9DJfGRvQfZP56GRU15hcjmIRNUGNgw/WT9+YnobvJCpHMaf2f7ZPlR4juEMw/6YvXHYkAmAH0EVS3SIux7352kpoaRitghlXvuGlOIZ8l37de5Layot6zSh9jNrRGsd5twYQmTeFErXycRp4VV/YA/VNRNF7BwjYbi9LpvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrz59Y2ezGEepeiBZUQu9fmyojMmVHzhwD2VnnjhrmA=;
 b=XacLaZG2UfjMVo7iLuHZcIaQHEPFpyIygSDnaboPuWIXjkYCT0uw2Vf+DQLjQXU6k28cRqDgJihcEXWE5CfxNguc0Bk/qGUzU03wSgNCL/a4TKHfUnSRIkczk+HdtI/RGs+NvjV+pn1ZsIdsVdqkDcnL0+S6PnJkOyYwIOEBnhjQirswwtxP7FvfEhWdhev1EbipvkDtrZfwaIGAh616vczKFOs/zqvtoIj1REvqtM3McZXMd/XfnDP2dG1GdFOD/BFaQSBHIY3NKK9ltQZ1wGekdIUnX/CJrLscAMqr/VpSQjt/RIVuQfJncO1V9pFq45V05iXZKRCWsuBZGoRoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrz59Y2ezGEepeiBZUQu9fmyojMmVHzhwD2VnnjhrmA=;
 b=SdoKzoCHPUhVt5YnMEdsbx+Vrap3uORGWt5VnK44qyViaMfq26nUxc5T0jmkUMMgOh7hcReBYF8JY5CvA+MRRnJw4IgeJ193fma2OVxAQ2lVELkVmJ64t59fOiJbGt0ihOLhK/J3acc4biIVnHBA8+KIKniJ+ubCg0smN5HLdYx62Oy+NH5fpPn+uzEu9DyJZstvbYb7YRmCIsEfqhi5b95pdjCkM1eVsXmWBZTxM19PTjbyzohuicOG/mHPya4uidscc0GoYfL7fTSpUFBeNF8LB2zQFN2oEj1d5Dt/SKfZJOUT3zKWOoGImLNPiiN0Sr9jaQUWP+90RIl75p2uXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PA4PR04MB7903.eurprd04.prod.outlook.com
 (2603:10a6:102:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 07:40:19 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 07:40:19 +0000
From: haibo.chen@oss.nxp.com
Date: Wed, 29 Jul 2026 15:43:28 +0800
Subject: [PATCH v2 2/4] leds: pca9532: check return value in
 pca9532_setled()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-led-fix-v2-2-09ad218457bd@nxp.com>
References: <20260729-led-fix-v2-0-09ad218457bd@nxp.com>
In-Reply-To: <20260729-led-fix-v2-0-09ad218457bd@nxp.com>
To: Riku Voipio <riku.voipio@iki.fi>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785311027; l=2911;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=JBuoJ1nVcsUbSQl03SDK/m3bcbiyiFp/D1kAXEXK3Zs=;
 b=DelXrnQQLHZgaKau1XMZn0QRjIPQU37RRpwzMlpLu+17j29BqYuV1HcKPeUVJh0OAFMaWXg7N
 VGoIz3QirQbDIMUmFDxNjXa+wwHk76qG0ddWqGs10kFWcWq0pVF+v0p
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::19) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PA4PR04MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: d729a302-13d3-4675-3cfa-08deed44a390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o95FQ1p0W3y1cOy9fl0QiW5lgN4KXxOzbMecaR3s4756leKcak0skgSFXCMIPNUqIjhoGwVHhseBdq+9MXIlANMpHtgcMHjKC4gPqvUO1oJh7Zo+WjgHO0Ibk/VsL+X2FAMgp2cqNhVABbRg5CmexBwSMiHNnCN5TgWlgalQpdltAWIvYAKuQZGxjNCwurxoSEhfzSeesrnK1hZVoPaSj0Y/2thlOpnYzxbcC+7UZs+bEeC3DR0VSw3enUE1LLWM2rOp4S3C9ktJtWkbJ/Q7WnJPBg/0jbgJCagD4tT7/N++j1beonj9LkTjBsxjxisI9wrI3uZxP7mU3kFSiEYgZilougydKe0Qux+lVN5nzQVi7wF7AuDBpTyyg9kmKONs7Z7h3s8GXg3W1mrcN8HAwVleK8uoiN5MVFuoe7wk4pVGfMhyf6X+uBQVN2EorwbijUWaov//a/Scs6IWyWTeWq//jYmuqvdv/hRMsYNjAVWGRLY+JaxGbd5Uq/AylJa9yjfL1EoR1dQvHkZD5UyDOLJQfkfzhHFsm47jJfHMvPW065AqCRGEwqETf64Tlp1wg1sErRkfWGaTWttQCY8Xr4xC9yzZYjDSfV4J6rDebqt7So+ZZBH5XD5ubwrmYV9W/snfwp7qqwxbcwM4DFmcXfqqq6TYCSSwm/odG0AUFqs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHhoT25TeW9nRG9CTjdFMDJoNFA1Y3IzMFptOXN1REFYTkdxaHdMVGE3RFVJ?=
 =?utf-8?B?M0U3WDZvcUxGL3RBTGg1MzVjL1U3QU1hNUErQVpDai9OZCt1Sks3QXNEd2FD?=
 =?utf-8?B?OU5wN0JFMisrQnIweUZEVTZvMkZDMlIxeTFLZmFJQnpUdHNMalV0TEd1VStK?=
 =?utf-8?B?SWdHbjMzWnMvejk2MUZENU1FaW5KWkhuQ0pqOE5Qb1JPM3RHVnk3NDBBYVUv?=
 =?utf-8?B?MlJvRi9PcFcyOE42SFJkd2h5bDNSamQ3SE5TUW04K1BSWHIralJraHozaTd5?=
 =?utf-8?B?bkxUeXltcFJ6dy9zZFFBSE5iY3VISWhzRVJzOXdpNk5wMWpsSHBISENsN1c5?=
 =?utf-8?B?czV1R2piU1lYREJ4VEU2WnpzWExLd2NZVFRSQ3N6KzhwMEdJQ3ZQZ214WjNs?=
 =?utf-8?B?SzFDSXR6WW1sa1hNOVRZOFROQ1ltUEFxSE53KzIzcU1zWlJ6THVPS2g4WTc0?=
 =?utf-8?B?emQxbnhxWVhpS0IzQmRkMS9Gejg0cHJpbEVoa1N3bGc3TDhlNGhZWkpFeDl1?=
 =?utf-8?B?c2MzQVNpaythVmdYMEd5WVU1cWlYOVZBMWNUazhvVTdQUEJDckxaN21oblhi?=
 =?utf-8?B?SUZ1cDRMVlM3VjNwTHB1T1h4bmlSNDVrcEtEaGdZR3djSjM1eERpbm8vWXJr?=
 =?utf-8?B?b04vZnMvSTRyRlJwSzk0TlBFKzlDK2VnbW5RSEJmU21qZXJjS3B3OEYra3Q1?=
 =?utf-8?B?Q0RyeTF1MEtUcjFQbWtHNGZhS3l2eUpLV2laUDZLcEJlVTZsanNURmU0T1Nw?=
 =?utf-8?B?VWZ3TU5lV0F0MUdyeThOZzRaU0lrOVl0QkY1Q2JSZ0Y0UTNQNVlRVFpWd2dH?=
 =?utf-8?B?Zk9kejNWaDBuaHpiaGs4blM4blZIbTdXc0NnVTdjM1dXMElISDVncm1Db1J4?=
 =?utf-8?B?THRGc3o3RGF6N3lFMVdUd2F3a3ZKRE5pWXJKaGtUM1Z5RTJmaEVBdkJHa2dI?=
 =?utf-8?B?ZXoxT3R2RjdmQk1kb3NnQ1dQY0N5V0JuYWM5TU5uRThESTN2U01SbS9RZHU3?=
 =?utf-8?B?dlpIRXhlQUt6YWRIVnBqamR0VzFTaUUrMzdVbmF2VlZZTmx0NkVtYnB2allQ?=
 =?utf-8?B?cFZESWVwV3p4djNwSEVRVmYrQ1d5aTRhWHI5alQ2RjNaRnFYMFN2dHpheXgr?=
 =?utf-8?B?c09xZmR0b0JmK2loQTBnS09VYUhFZUE3bXBYV0htd0lHUUNHcTBETGJKVFZi?=
 =?utf-8?B?UlpFRStodmxzME5veFA5Rk1SQmk3L3lwUmxTbjBmL2NOR051WUZlUmtoR2ZM?=
 =?utf-8?B?UnhhQmZPNDY4djdVcnA3QkorM2xyNW9QdlJCdE4xMEVDaG9nVDN3S21ZNSs0?=
 =?utf-8?B?MXNyOFZsQXBVTGVva01HU3JKcWNRVzhvNW5Ia1pwaE96aHNBcExFVzFKWlY4?=
 =?utf-8?B?VkRoaXRmKzdUdG9HVXpadU8zRXpnbW0wS1VacTFaK0x6Y3ZLd3poMmRPdXlF?=
 =?utf-8?B?NmhaYW5lbjBGdmRVOUFkR0NnU2VsYzcrWlVlZnZIeHlTYWdSOEZjTDFaOVMz?=
 =?utf-8?B?UXVTZnV3YnZLZys4Z2toZXVOSWZ5Vkl2d3ZBWUl5MDNMN0RHZzUrYVJNWFBT?=
 =?utf-8?B?YjNzLzFqejUzbTM4QTR6UGV5NmJrMHQ2MTdMZUQyd21qbFJpRmVzbXpzWTYy?=
 =?utf-8?B?SjNoQ0dqVC8rSldZZ2E5UmFOc1lQT3NVWi9vMlFvcW11eUk3VUxrbi9raTFZ?=
 =?utf-8?B?dE95UTJGT1BTQ0NHNmIzTkpqeGlhUmEvMFNvcU5xNGtCSHMvQ2gxa09mbjlE?=
 =?utf-8?B?T0xLVUZ4MnhSNzREY1J5VU9sVHp4MFZtMkF0eURhRzVkMkt5OTlIUjVsSHlD?=
 =?utf-8?B?Nlh4Y3JYMHRNNEIxTzlCM2pubWtpTjIvY1h4SHFzOFNseXlSdFdJVkFWeHJy?=
 =?utf-8?B?bWw2TGd5NGVaQXNXSjlqcWxRa2xKS3JKTXRqK3NZY3ZXdTVQaEJnV2FXeE5Y?=
 =?utf-8?B?UGVITEFpUWhIRlc2eWFMUm1zQmo2NFB0YTFrSE9RYTcwRDgxYUpzQTAzV25y?=
 =?utf-8?B?azJKKzhjbmI3RWhuVHpxQXhpUkJvNjFXV3hMQWp3dE5DaUsvTzZ1ck5veDZB?=
 =?utf-8?B?OCthc3JSUFd4L1RhazkxOVVtczZzcy8wemxORmRaa00zQzR5M25zRXVic09U?=
 =?utf-8?B?SW4yTERFcWFIQnZFZ2FwNXZmc0R2Myt0cEpxMklYeWM5QnE5elZqcDlVTDli?=
 =?utf-8?B?ZGhPbGtuRW5kc1YyQVFMbWxsc2J1L1JuOGZGSGNxZmRhcmFkQ3pKcjUwSEx0?=
 =?utf-8?B?M0owTmZDanlXUUh0K3JHcGg5MEJMLzJ5ZUhsYVFhekRPQi9pSHEvSTFhbTc5?=
 =?utf-8?B?R0ZVYTBuZ3N6OVNjSUhWUUV4d1owZ3g3SEg5dlVVQU9zcGpkbTlBaXkraUhB?=
 =?utf-8?Q?htGZODBE56eWPRlBqL1svYcfP8US3qXKdZTP9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d729a302-13d3-4675-3cfa-08deed44a390
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 07:40:19.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tro6Tw5M5JzEPGRCd7VsBKxhAydjtmetEbU2pBkjSWSsCbGRrCKnWPF2WfNQcryEjJXMdIVAOPLRvZSj5PITExLyVhXiUXeT6+oJNSbv0+Jeb5u1xuex8b23e9dg46AZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7903

From: Haibo Chen <haibo.chen@nxp.com>

pca9532_setled() reads the LED register with i2c_smbus_read_byte_data()
but never checks its return value. On an I2C read failure the function
returns a negative error code (e.g. -EIO) which was silently truncated
into a signed char, then bitwise modified and written back to the
device.

Since one LED register controls four LEDs, writing this bogus value back
corrupts the state of the other three LEDs sharing the same register.

Fixes: e14fa82439d3 ("leds: Add pca9532 led driver")
Cc: stable@vger.kernel.org
Assisted-by: VeroCoder:claude-sonnet-4
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/leds/leds-pca9532.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index e8ee17b8bd547a92372a8e74a6781b95ae831fe2..adfb5aa50e8e1f3ca0deb9261d8c9103903ef928 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -159,21 +159,29 @@ static int pca9532_setpwm(struct i2c_client *client, int pwm)
 }
 
 /* Set LED routing */
-static void pca9532_setled(struct pca9532_led *led)
+static int pca9532_setled(struct pca9532_led *led)
 {
 	struct i2c_client *client = led->client;
 	struct pca9532_data *data = i2c_get_clientdata(client);
 	u8 maxleds = data->chip_info->num_leds;
-	char reg;
+	int reg;
+	int ret = 0;
 
 	mutex_lock(&data->update_lock);
 	reg = i2c_smbus_read_byte_data(client, LED_REG(maxleds, led->id));
+	if (reg < 0) {
+		dev_warn(&client->dev, "failed to read LED register: %d\n", reg);
+		ret = reg;
+		goto out;
+	}
 	/* zero led bits */
 	reg = reg & ~LED_MASK(led->id);
 	/* set the new value */
 	reg = reg | (led->state << LED_SHIFT(led->id));
-	i2c_smbus_write_byte_data(client, LED_REG(maxleds, led->id), reg);
+	ret = i2c_smbus_write_byte_data(client, LED_REG(maxleds, led->id), reg);
+out:
 	mutex_unlock(&data->update_lock);
+	return ret;
 }
 
 static int pca9532_set_brightness(struct led_classdev *led_cdev,
@@ -196,8 +204,7 @@ static int pca9532_set_brightness(struct led_classdev *led_cdev,
 	}
 	if (led->state == PCA9532_PWM0)
 		pca9532_setpwm(led->client, PCA9532_PWM_ID_0);
-	pca9532_setled(led);
-	return err;
+	return pca9532_setled(led);
 }
 
 static int pca9532_update_hw_blink(struct pca9532_led *led,
@@ -257,9 +264,7 @@ static int pca9532_set_blink(struct led_classdev *led_cdev,
 	if (err)
 		return err;
 
-	pca9532_setled(led);
-
-	return 0;
+	return pca9532_setled(led);
 }
 
 static int pca9532_event(struct input_dev *dev, unsigned int type,
@@ -334,9 +339,7 @@ static int pca9532_gpio_set_value(struct gpio_chip *gc, unsigned int offset,
 	else
 		led->state = PCA9532_ON;
 
-	pca9532_setled(led);
-
-	return 0;
+	return pca9532_setled(led);
 }
 
 static int pca9532_gpio_get_value(struct gpio_chip *gc, unsigned offset)

-- 
2.34.1

