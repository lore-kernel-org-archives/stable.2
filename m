Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.95
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204067;
	b=Vzj9yPCkUfcYToDdzJfJWB8COfVH5eQf6YGkHh63Nmc6aP9VTFRiaUUPv2Ym6BFOnNu3
	 hJ/lKp5Bi919VIipgWIRKWiv71tCwmY+2tNqI1aRTaSl5hkdvVpKY5vsnGNNZx9AcR9Jj
	 7iO21NdOTWYtD/fCr/UNH+YkRN1VyRd7IjF3/OC3/e9gLLhC+ykodwabr9RchiJAkIjFH
	 TK4SDH8j5fjJYQW3ro9U9EnreCNvwSZQhyAsUlwAaC8/mmSjoQ+5Cn670kalrb4yXoVop
	 yot7+buYumVSgADdsruVLrqLAuXzVoeBN2RlcUvQL85ojlWaXmsXTLmB2YmgJpam1PA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204067;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=x7GFqg3Obacpb27VFcaDGj+aBD0AjUbvhyFKMf5u4mA=;
	b=CWk98wY3kX1TKlMJri9V8vyZl2/1Dygq+08ihGDRRJ5/Lt9ms0EjorLOsp2ftdu83no0
	 zj9DGZXHjeunPgq6hSqwqPu0TLmJSlRV9rwdMp17ExFIlUBDo99LReZKk2/Piwi0gkrij
	 V+RjharGcVKoZ6I/bnQgYDierl2fcCntDUk4bOZMPqKi82WLREAm1lMdic1c9GkiX29eI
	 hbbifxw632q9NlvOc40xCwMsgcvRjO6albZp1hByV/s8pFXmj2hrpIRF+NSHyU+72J3bA
	 9ufSsZO1719qg1Xlr8zDxFpFaAVS2cVetJvPegr5asbn0IlXK76vYP5WmPFRGi25f7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=QeScHbdx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.95
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010095.outbound.protection.outlook.com [52.103.10.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C610606A6FD;
	Fri, 20 Nov 2026 19:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C610606A6FD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=QeScHbdx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8Or/z62/iBLfT5SKZY4B9pJjah8tfz7DR84V3kg68ObGMrEKTRCJZamBPZgOhBTGk4Pfa0rR5KmMYeWmML/xwIJdXfpwBiT2BvDO4V39+aBD3S4uuANyaA9D6lx6Wn/xS9WXF1RwG+bbx56S8WlySkvl4jo5WoizNJK1JSrIisYRRhca78RNIqi0hv7xX4OWdu7nIt7NmPfJStUV+vF9YJ/unTz0Urc2+XbQvIc+A4tTcCYaICE/KcnEXJrcz/iYIrXJScZbohICQF+QMOeBlMWARRMfNfWzfTb94CU0NNT+rYbZih3oyZM5PnjwSv8DTgtkz2SJm78sX022FUHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7GFqg3Obacpb27VFcaDGj+aBD0AjUbvhyFKMf5u4mA=;
 b=oYm/LZn1N37SA5/eDeBh8FSqLytFalXDFe6o+TFq2sZUQo6rVHvyuMYWtMpMEv7+Ibbh2OVBGp8+vZZU5g4xVuglZ2xKxDe9hd8Hf9danX30aGSU+mPz/NOxoye+wheIT0u0TLLnDSUQBF7J1k/iIDSqT2jaywKNGILOxcEYlpB2zJf9CNZ6bb5CHlJ+SGB9MY5yAX1F7Lcwn9TChUxyLOxqhX16PHcrNCviSAD13mwxj3YhSoxhrVfi/EFsXrXrtPlfdnHDjNFQdvnkmXzS3AnVGzYh5uIBGVy3vEJThrCb9z4H0aONZZa3S2YrvNwDr2+gN0dwTx4YogUPt9MPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7GFqg3Obacpb27VFcaDGj+aBD0AjUbvhyFKMf5u4mA=;
 b=QeScHbdxgBIGkDoh0Gflwa0yFTp9NusWuPSIrPHFXNMPUcSFASs1Sy5Jmea6blyPOxM3gTAbTUQ647JHKDUZplbWNSTZQEWhsrCs5LbmP8COybYdE0+nyyiTt3jDHnnpYSwOro3KCWxY2J+iU+V2YgDzis5B0ptplwnZsneJhxRcFlGXu5xrAvlOPFELRsw5YG1SH2iV/A3C1fIA2yWyKC3tzlvuNMjEvJkl4Wc14ax1ov6RcpJWMjhzOSd673J5jGny8EvGwz2YNaAJr4La1rJvImc/kZacPdyRVeDuNI7Hdk7EyGeY83JSgykTtvbiE4f4ZFZ3V7KzBsxWWdeuUg==
Received: from LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:2fb::15)
 by MW5PR84MB1665.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 19:47:38 +0000
Received: from LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9151:9e8:f98a:99e5]) by LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9151:9e8:f98a:99e5%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:47:38 +0000
From: Perry Dale <techluddite@outlook.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Dale <techluddite@outlook.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 1/2] ASoC: qcom: q6apm-dai: queue playback buffers only while the graph runs
Date: Fri, 20 Nov 2026 11:47:24 -0800
Message-ID:
 <LV5PR84MB40260AD8BB8842BA97269B9DA7782@LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <LV5PR84MB40268B01B9F458296BE453ACA7782@LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM>
References: <LV5PR84MB40268B01B9F458296BE453ACA7782@LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:408:2fb::15)
X-Microsoft-Original-Message-ID:
 <20261120194725.4088815-2-techluddite@outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR84MB4026:EE_|MW5PR84MB1665:EE_
X-MS-Office365-Filtering-Correlation-Id: f86de986-a4c0-4f22-8042-08df473f217f
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRgLZ5qdaSz6AV8zICdvjdtl5Qw48ELqMGYMOgGtg36lRAM+M0JeRggR1Qpiw21O0BZb86qZX1T2XCWEw6HM9expujjuTueuQrjjV8QnhsZIHrWRy2GJo4Fjmcjtz2OBL1Zk1ZpnZfqqJ9Lp2/WDtvxH5bh7SU0Uo0vE8t/ef8qf8R80lZ9qGVznQ7MgSRYK6iclciisPDrJx5dqX581Lh6aujq7RibqDHdHbW+i9oNIgtmrnSCZFHqQkviXVw/yDTj2urJJF8ecmogrATPDW8uhOp/csfPTzIHwesCyNxcQXkvVO/eSRGgNeh7HYiPVJbPczS1v1i310Sbupyv6Y4TAwGn5wi3PDKJMWpK+0V+ceE2EtJj0iekBPeNpUGK+LIuQP3qZKTu+9e+i2zXsY7PjZWnwnhmfm01oc8/Z3JtZ4+Yq+ePxK7OkzcgcPJql1iRz5wOvWI2cv25ZgFj54FoIONXWPlE6quNR98MRKyfDRNNxjIFMiNK3AfBMEWiRil8KQmhA8UO/9I0s9Qme0kI/sn/4F5a3DKJUNt6/w9rW2Xmq5JNALRTrS3fPD2Tx15MOvktBQqH/naCzcZLWz61jb2V/LHyOx3+UxU8UsxX5oINitfNQ7XHJO37WdHCdlZD2TUF5YYA8UP5PzyD1b5Uu30cumczgUpaws6Afi93qG8VXNzLlne4K/D7MQPzehADiFmRqbqxLGdiFmABd9SSoSJxvBJiP/rQuWEfDS+KU8=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|5072599009|51005399006|25010399006|23021999003|15080799012|24021099003|19110799012|260925184616899003|41001999006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VGH0x9z5kIoaxrRAtPBDc6tsVOwYpdIG8BIfMnJnpR9/0viLk1TbpZAZ/cE?=
 =?us-ascii?Q?PxwJTZxVSTt+C8/uwx7nw7VTHH/OjXpq8gcUtaI8hCvljQTJWf+jx6VAWIwN?=
 =?us-ascii?Q?ZYZqM2AVD7YlVy7EUQKJql8ewOSTv6yRSzmfL0cNOKcRPupfUFXC7ZFBfwft?=
 =?us-ascii?Q?i/hCyL0y89d7fXdD2clO0E8Tu3sASCEYUCjLrds5rbiuQo6sWAqfPbmBNBxu?=
 =?us-ascii?Q?mcffT8ID7LeymxnyLXq88wgTjj6u09VMfn6dZ+fsg+6bircILdjrC4quQmxL?=
 =?us-ascii?Q?lNYzN4ZAGEiDxCrSUAZGF9dOsdrCOXjlAEGqBAiM3F/uMenfwzrLp1V5UU3/?=
 =?us-ascii?Q?RGfps21AJXXyeJ528NCOPaiK+NVM/MhWMRSIaHLoFbwjhMxCyzAOjsteClpM?=
 =?us-ascii?Q?CoUr6Ju0bBcgJAGwi0SnHkyCnzrvqMOWZjnX0iJIk7HvSC5bzUSUcxU2m2Fx?=
 =?us-ascii?Q?gW2xUrncordOA6NHjuWS/BD325axYDpZsKlgF2L7FHzRe8R+Tto/GP/RXTNP?=
 =?us-ascii?Q?ez7o6EqhZxofSip30xsetauH/lBU3dSZH8D16A89NzAyzJUDi3KDl3y32AI7?=
 =?us-ascii?Q?3o/1apesEEvHZrs5Ewga3ZcmK60gKUgq4n5tkHuBy8//cXvIX69B503HQ2fT?=
 =?us-ascii?Q?Miwr4KfpnYHFBPkLF2B6XNig7RFBp/WCjm3I9RCvQNDtTC6KY5AX/BGwiE06?=
 =?us-ascii?Q?jDDZnSORuMV/9f8fFw5iJbncSAmFah5adV1CRGm5RLUdcmwLeJH97sao0NUA?=
 =?us-ascii?Q?2StH023+5TPe110VHqhFokQhqsoeEukyLLPPsoqUzc3AZD1BQfKRW9gQtLwm?=
 =?us-ascii?Q?iFV0gPiK4nIFqpSF77KxkA2iBC4JkK1nj1eVGLJdmKPjk60mDpFgmNOyPCKi?=
 =?us-ascii?Q?ScpUd8A4796G3YU/l9RwrXB//PqJbxAPdy17To/z5YlRQJ3vI3FGGXaRK7ps?=
 =?us-ascii?Q?/62Tordzk8Wf366IlDcrfkrN3cHinxL98DQYwSjvDU3VwXXq7INoFTIuemch?=
 =?us-ascii?Q?Vzbh?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8zuNxMj8Z0si0WDIobWfg76vLMei4evq6I6ipSo04uOhHZhU0YFHSIBd2dVW?=
 =?us-ascii?Q?DNPgwia4NQZO20gKiuQzJu2ppq5ba7hKuj2Te7StPNo45FPht9Lzb2GoDAgJ?=
 =?us-ascii?Q?Y2GwsrBk9JzTRzXivcr6mnbi02URo7iUnlmaWWk2q29d/1wwBBIts33w1b2O?=
 =?us-ascii?Q?sfq2lLEtYP0Z0SWFBkSlXVnJe47bKaaTpeN8Wcv/k1z9hYdzkhGva581IN+X?=
 =?us-ascii?Q?x2E7bjtcfId/jSQ0csabnhSbYYt8qhI4G1eHMMC22haC6mbXHW7HtdiLQkqx?=
 =?us-ascii?Q?HC8aRJx75+wjysG2NPBf7vwIUkVoyb10K1tNWAm13L0NgZg/RxyZkWo+U8zw?=
 =?us-ascii?Q?SDvSNZD/xvB6aTe63v+K6SBQ2e0yUGRtGceAm78yiF8sPnuAbC6tihFitcGj?=
 =?us-ascii?Q?XqMjKpGYCoa3zK4hJZT4xWQ9ietHFMVXx/RRITV9DippWJYmM1U2JUQ7B1Es?=
 =?us-ascii?Q?danAC2IPx7KD8UEEDyHlGsrQLVYzhQV7N58IJmcCdsFUi+R6bRVO9Te+eiEw?=
 =?us-ascii?Q?xsFYDAzAVvhNbSiyZgzSfNP/Xfa2Z5LUfL+/2X0n2c/5PW9Vmb3e7u2mPN3o?=
 =?us-ascii?Q?NogXizm+3oHtiwrQnxUsmTr8Ek6Ul90oyV7zf9GRiEHFW5aT6s9E7qNXxcSH?=
 =?us-ascii?Q?A6ioqX2/wIQ/+w2xtUhgfmlMW0Kzrq3ebeGk2XBIBIBN0lSPDKTfuDAovuYA?=
 =?us-ascii?Q?cvwL9ovDDiLVSfJ6oGE95woMGVvqYCIM19rsknsEa6rTmK8PBFrTm9bgGi9X?=
 =?us-ascii?Q?H8NAws0q9ZMIKTF8qHlTYLnqaiXrhh1WYnkwyrSU47bZuZ3zcskyn4FsjCPs?=
 =?us-ascii?Q?4IkS7IOEyg3IHCGCEshWSnySjhI49O7+N+DYlZctLLhrclZMClqOuKXKw5g8?=
 =?us-ascii?Q?zkFrOP1C3tP85K14SLWMJ0fQqgfrKvB4XiPreBOrCVPEAs5g8B/xcDVOJvZh?=
 =?us-ascii?Q?IT3yzXiu1mRJrHUn68novMf23v4LDqFDYxiU53+pexC/1tRpAAhQo4ifzvvk?=
 =?us-ascii?Q?dsNr0/K2WvPOpGExQmUOaz3wwcEOLd/EiMFzz1A5JdKdljvXjYlbPgii1rX2?=
 =?us-ascii?Q?e53XLncs4TRYg0b/S6ZM2PL75Ko1z1Ud8K3SyMEmgMys4uQGMW7X1mC2YEFc?=
 =?us-ascii?Q?AgvON2Q37jnqdFMhgK8ByDfmIELoq7ZZyOc6mafiL5L+UND/aWdGM//xhHS5?=
 =?us-ascii?Q?jy2eR0OSSPZTQy3GX2ZNUdttr8R9CnrJjRwKkhueIIHFPGDILI/2ZVMmHxhP?=
 =?us-ascii?Q?X79ZVKdSW7V/XEtkxCfXaspdS5pZT+F1ZB/5L+J2yRC/mHzCfUrBhNsuq/i+?=
 =?us-ascii?Q?DDYm16C3IZ5sugGITuOAM+1iKjQ0E5g5gNEi7hfjZh+NvAAL7baxeRSO6fpz?=
 =?us-ascii?Q?knCzf2N6FdtrDcx7/RXvhWJrQmAx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86de986-a4c0-4f22-8042-08df473f217f
X-MS-Exchange-CrossTenant-AuthSource: LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:47:38.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1665

Commit cab45ab95ce7 ("ASoC: qcom: q6apm-dai: reset queue ptr on trigger
stop") resets queue_ptr to 0 on SNDRV_PCM_TRIGGER_STOP, but ALSA leaves
appl_ptr unchanged until the next prepare. ALSA calls .ack when a
write, a forward or SNDRV_PCM_IOCTL_SYNC_PTR moves appl_ptr, and
SYNC_PTR can do so in the SETUP and XRUN states after a stop.
q6apm_dai_ack() then computes avail_periods from the full appl_ptr and
issues one q6apm_write_async() per period. After 530 seconds of playback
at 48 kHz with 480-frame periods that is about 53000 writes in one call.
The glink channel runs out of remote intents, the write fails with
-EBUSY, and the DSP stops answering GPR commands. Every later prepare
times out with -ETIMEDOUT until a reboot:

  q6apm-dai ...: Error queuing playback buffer -16
  qcom-apm gprsvc:service:2:1: CMD timeout for [1001003] opcode
  q6apm-lpass-dais ...: Failed to set media format -110

On the AYN Odin 2 Portal (SM8550) PipeWire triggers this when a game
pauses its stream. A test program reproduces it by playing one second
on the PCM, calling snd_pcm_drop() and moving appl_ptr forward one
period with SNDRV_PCM_IOCTL_SYNC_PTR.

Queue only while the graph is running, which prepare sets once the
graph is started and trigger stop clears, and only in the PREPARED,
RUNNING, PAUSED and DRAINING states. A drop before start does not reach
the trigger callback, so the driver state alone does not cover it.
Reset queue_ptr in prepare, where ALSA resets appl_ptr. Prepare runs
without the stream lock and a second prepare finds the stream running,
so mark it stopped under the stream lock before the graph and its
buffers are replaced.

The same unsigned difference is wrong in two more cases.
SNDRV_PCM_IOCTL_RESET moves appl_ptr back to hw_ptr without a call to
.ack and leaves queue_ptr ahead of it, and appl_ptr wraps at the
boundary while queue_ptr did not. Both can queue a burst of writes.
Wrap queue_ptr at the boundary, take the difference modulo the
boundary, and queue nothing when it is more than ALSA holds for
playback. That also covers an appl_ptr moved more than a ring past
hw_ptr.

After a reset on a running stream whose hw_ptr has reached the end of
the first ring, or on a paused or suspended stream that far along, the
stream no longer advances until its next prepare, and the DSP keeps
answering. The next patch carries the stream across a reset. It is not
needed for stable.

An .ack between the end of the driver's prepare and the point where
ALSA resets appl_ptr can still queue stale data, as before, now at most
one ring in total.

Tool use: drafted with Claude Opus 5.5 and revised with Claude Fable
5.2 (Anthropic), run in Claude Code, from a prompt asking for the cause
of the audio DSP failures during games on the Portal. The tools
analysed the kernel logs and wrote the test program, the change and
this changelog. Built as a module for 7.4-rc1 and run on the Portal
with the test program: plain playback, drop followed by appl_ptr
updates before and after start, resets while running and before start,
underrun recovery, 30 drained streams, and 40 resets and prepares while
a second thread moves appl_ptr with SYNC_PTR. The DSP kept answering
through every run. The resets on a running stream stopped it as
described above. The unpatched driver fails the first drop round of
the same program with the messages above. The boundary wrap was not
exercised.

Fixes: cab45ab95ce7 ("ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop")
Fixes: 3d4a4411aa8b ("ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs")
Cc: stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Perry Dale <techluddite@outlook.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 52 +++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 58beaf906..d0d19fc38 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -345,6 +345,17 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	cfg.bit_width = prtd->bits_per_sample;
 	cfg.fmt = SND_AUDIOCODEC_PCM;
 	audioreach_set_default_channel_mapping(cfg.channel_map, runtime->channels);
+	/*
+	 * A second prepare finds the stream running. Stop .ack from queueing
+	 * while the graph and its buffers are replaced.
+	 */
+	snd_pcm_stream_lock_irq(substream);
+	if (prtd->state == Q6APM_STREAM_RUNNING)
+		prtd->state = Q6APM_STREAM_STOPPED;
+	/* ALSA sets appl_ptr to 0 after a successful prepare */
+	prtd->queue_ptr = 0;
+	snd_pcm_stream_unlock_irq(substream);
+
 	if (prtd->state) {
 		/* clear the previous setup if any  */
 		q6apm_graph_stop(prtd->graph);
@@ -415,7 +426,9 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	}
 
 	/* Now that graph as been prepared and started update the internal state accordingly */
+	snd_pcm_stream_lock_irq(substream);
 	prtd->state = Q6APM_STREAM_RUNNING;
+	snd_pcm_stream_unlock_irq(substream);
 
 	return 0;
 }
@@ -429,8 +442,43 @@ static int q6apm_dai_ack(struct snd_soc_component *component, struct snd_pcm_sub
 	if (q6apm_is_graph_in_push_pull_mode(prtd->graph))
 		return 0;
 
+	/*
+	 * ALSA calls .ack whenever appl_ptr moves, also after a stop and
+	 * before the next prepare. The graph has no queue to fill then, and
+	 * queue_ptr is out of step with appl_ptr until prepare resets both.
+	 */
+	if (prtd->state != Q6APM_STREAM_RUNNING)
+		return 0;
+
+	/* A drop before start does not reach the trigger callback. */
+	switch (runtime->state) {
+	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_RUNNING:
+	case SNDRV_PCM_STATE_PAUSED:
+	case SNDRV_PCM_STATE_DRAINING:
+		break;
+	default:
+		return 0;
+	}
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		avail_periods = (runtime->control->appl_ptr - prtd->queue_ptr)/runtime->period_size;
+		snd_pcm_sframes_t pending = runtime->control->appl_ptr - prtd->queue_ptr;
+
+		/* appl_ptr wraps at the boundary before queue_ptr does. */
+		if (pending < 0)
+			pending += runtime->boundary;
+
+		/*
+		 * What is left to queue is part of what ALSA holds for
+		 * playback. It is more when queue_ptr is ahead of appl_ptr,
+		 * as after SNDRV_PCM_IOCTL_RESET, or when appl_ptr was moved
+		 * more than a ring past hw_ptr.
+		 */
+		if (pending > snd_pcm_playback_hw_avail(runtime))
+			return 0;
+
+		avail_periods = min_t(snd_pcm_sframes_t, pending / runtime->period_size,
+				      runtime->periods);
 		for (i = 0; i < avail_periods; i++) {
 			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
 			if (ret < 0) {
@@ -438,6 +486,8 @@ static int q6apm_dai_ack(struct snd_soc_component *component, struct snd_pcm_sub
 				return ret;
 			}
 			prtd->queue_ptr += runtime->period_size;
+			if (prtd->queue_ptr >= runtime->boundary)
+				prtd->queue_ptr -= runtime->boundary;
 		}
 	}
 
-- 
2.56.0

