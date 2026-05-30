Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EBF1D432D
	for <stable@vger.kernel.org>; Sat, 30 May 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780149079; cv=fail; b=VI6OdDmZFaJ7QpvpOaECqy6MbZdltOQIqoC7Zbi10k5/UZg0cOlG/xeqSmHlFwijldf90ixibbnfWAhjc8qbvLtzYnfBCTu9vXsuh4a6FPDXhOl7xGWt4TkCeKJFl8NJic3zBxNgl0SBSnInoNuOk64DKfbNn2ddsLWFyjeEcbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780149079; c=relaxed/simple;
	bh=Ds/39jWrRRt3Y/lrG/iTze2r9/UB6iJxmkYIG8PZWoM=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=c7gc8hDlYqAClD1YWWoTJBrY1TQzgdX8+VRyG9+5afBylatL86WjhU1MWL2dmfWIndJd44x5qsonqC5TjDyCE7XYFyETdBct1VVJpWG7POlQ8rql2vggJmI5RpNIINevmhOOhnSj5ZpuLJ0P7Kocamz4sE+QH9RZIZSZL8o62Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=E6MB1o5n; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="E6MB1o5n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWEWh2WxbWOQ6Wrw/GuaNbNPlrocQJH0z5sbONpx4NrN7TLY8p9QjLGmKu2lQPEIjuAK+lF0golbPLiFiKvCRx7qjNxb7h92TrvLocHzOuOEQP7J8FpCKn13+zKYTP+jgDNM1BE3STKIuRj8Grm/Q3nxy5YgpTwEtVa/idexMUprzSvJLuSxCvP1wrk8Zma0jUe2GVGkulLC7Nw3Q9d5RtgcwDpEQNInre1fDhZnRyS3byySzqxuMzM4CvpYAnGO8HGI4A9kKSZnEBGiWNphRIoudpQj9BSAODiF7txwjDqc2GsKHP1odKKbTlmvbhA6oia2sVtKPbdgGtuhvz9/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+i/tTAWF6x9JMqw9dU+vPl2jZcm1OI8nCppApibUEM=;
 b=sn2V0himaxNSJQZZ7atSEoKpOf7HyjPjQifcD2f//QlieJLa1SEOskO7cb+5nJBVlnmJ44ohvZh1UGbYSb3jBVO01lhXGQo/QpFhYQ34NSA66yHkM/0E96nPy/qu1aakeZTkFXYFkCGrjOLs8GXfWj81RnDV+K8HrmqFb+XxaVZmtIfBRYcNZSTa8d+dmTtNA4zwygIFiRs1zMzSj1LBi0xDakIqZub3d0dGvbd/m7GY8rnXFdpw/1GGDGQMtoiFGltSEEKGoaSXkZs6ARqYFCDBMPY+288aryL0vBGKR+bkc5w9CDSIPuPvER/v2cSZ5+mz6hE/ifIIUgfFfZ/5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+i/tTAWF6x9JMqw9dU+vPl2jZcm1OI8nCppApibUEM=;
 b=E6MB1o5n2mOjr4EbhsWTcWcu377EZBVl8G0697HlT86Dyd0o2Y3VERrZkm7xNSuwrjwYlkYYiyjGTw1Ho0NmL2APJavjKuFt+RLRNPmiWcPOJobyLQAC+rsKhNxQQ0Nda/9dFNbROacX/hGD+ReGHOJQIF7qAq/eFueUxMpB3uXDdeeInVCniCBZq35dnCRSaXJUxC559ku3ptACBllcEp5x4bfcsOXZbyghi0RPLsR/dn0v+CDcFn/RkGp9mfzVQYl46WfqCK2G3KWvfkmekSe6o9lUXBAYKWtNq5k9iUdv2H1pVSRBTfdMaNQzSc9R4rDiQOgPmopR1pJY/EkoSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sat, 30 May
 2026 13:51:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.014; Sat, 30 May 2026
 13:51:15 +0000
Message-ID: <f92f7417-9ba4-4a16-9f4c-77bcf212784a@siemens.com>
Date: Sat, 30 May 2026 15:51:14 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6.18.y, 6.12.y, 6.6.y] media: rc: ttusbir: fix inverted error
 logic
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Hans Verkuil
 <hverkuil+cisco@kernel.org>, sean@mess.org
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3729:EE_
X-MS-Office365-Filtering-Correlation-Id: 437a23a9-6204-424b-9db2-08debe528477
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	v7tKh52fAAMlxR4cDycYhVQx3+OWv9zO3Zjj2q2/jI52L1TMc3Lpd+oBoAf+MLFCdYn9v0izhakYorzyeOPHi7IDvV17WmAJji9Q8avtG9iSCeeytDl91JPYbmWtHaglAUbAV0iPHQt/eYqj7wcjytrhs9O4u/bLG9elYzsf+CurI2vBEgmygHhYqs7RJJSAFOLhO8asOBrWxJwVPZXKCq7t+/FL8VjQF7Ec5erCndB89aiKen/aJp7HRMhOZta1tmmkguFcakr4w8T4DV8Q0BoLHhmUNFjXA414fRxyu/doWscFWZVDgerKr/IlicfFKB7gUHYBoEn/mnBcb4JbEnLX0kJO39SFXlm6WDq9zFHOB6QbjxNSpHrOqTpqzG0s0TAv57A/mCseVID6z3Nbb+nqc2RBvO02tlSK/L2Jspga/iPX/Hb61uRtPUCkvdKPDUMQmNP/PrHXYMDk1O/6legvaHPA8fqcFZiHYGNNns/8n0R2q0Yw2rSRnEsEYvg+cwPQcVYtYHG4nyoxnyvmAZATRuuR6mXrXJCeDKt4TndRpQO8/cj9HW2clTz7KX8gqLoAFaC3od0pMlenqN8mmvGEukhp9yk1b0eVSC4SQCIbYV8BLAJbJIScWTtLJfFRQKXVsqz70A1V9sDyKuI7XHUmKIf52eG1+IPu04jgChwpEwMIfUW23VnYjSEyjyAKVlvckE5bNRmdvcUBeiVM7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVVKQnY5S242THlmRVI0SlJidjRJd1U4VExQZGV3NUgzVXBaV3R1MGp0UjNK?=
 =?utf-8?B?blB4dVp5Zmc5NWtnVkkveEV5U3UrdlVtaStPTW9Cem1QNEdGYmhVNTZCYllE?=
 =?utf-8?B?Vi9vS3NtdHFqejV0RGt6MU1lc1NVd2Z6aEdkaWwwRStQUFNPQWZBOEpyS0xh?=
 =?utf-8?B?VFNYOExqaW45eWhZR0pnTXNSSWxvRG5pRzdTMHk3YUpSTUJNazVoaENVZmN4?=
 =?utf-8?B?ZFZ0U2JDbSt1amlqTCtyWDNGV3c1S0hNWXhCMDJ6UjU0dmRPYnBOUGErK3Y5?=
 =?utf-8?B?d2VIL2ZqN0pXK2JaeXBNeWVTQmtxUGMrTmRIZUcxa3FrcjZRclppcmdsVEFq?=
 =?utf-8?B?V1FvWlB5cDYzSXlCZXo2U1pYZ1QySkJPYWhsdlgxckc3WEVYc2lDUlZmSlVP?=
 =?utf-8?B?akUzN01iMnBoVFhPaS9CZzArWUxpc25jYjVtRWJGS0RHTjExZUlVQVJLMk10?=
 =?utf-8?B?V3F1TVgzaE8zL29kSWovYmxqTytXREo4SjYxeElMeEE5aEdRYmdDWVhxekUz?=
 =?utf-8?B?MVpwT0hrWlB0ZmxtQWIxRTZLZWJuWng4dDBGR3pIMmsyS0MwNkNCL0o2Z0lR?=
 =?utf-8?B?SkNwZ09BR3YzeXFvN3hiQ3pRdEdEckFSTFdnNGJ5dFNMV3cwMmo4V1Ara3ox?=
 =?utf-8?B?ZTRuTENKRDZxdHZkWkJtemFVd29LRjE4NnVmMEtINi9KTnRIR3luRjltZGdQ?=
 =?utf-8?B?dmVzVzhzMmZWYnQ4bWNvRXNCRGNLbEdReFNKaEVMRVpJNWZWN0VsS2YxSWJv?=
 =?utf-8?B?bnBLdUt2c29INGhpR2FuN2NFR1VxSkRmdEx2SGd6cnhKV3JVUENoRkQ5SkRx?=
 =?utf-8?B?elZuakh6aTRBK0J1OWYzbTNiMFFsQlFrTFp1c1A1Q0pPdlVKaHNOMXlVWkFw?=
 =?utf-8?B?N0FINUpIYS9DZ0E5OWZiajEvK3JwMWx6TE9FN3lYcWNxaHRjOWxIVlJiUFRx?=
 =?utf-8?B?MWR2bmRoNy94c3hkbHhJU2xVZ1RHclFRVFQzZmdPaE9BWWtGeGpnT25wUkxQ?=
 =?utf-8?B?UjYxdjEzNjVSTVVFTHJjWWJkREtWVktxa0grQ1MxQTZmdlRnTTNzYXB3WUlF?=
 =?utf-8?B?Q1hyNDd2bS9aV3hkMEdNd1NKNElYTk1UOHNoeWlYTVZUK3g2Y01yMlM1YlpX?=
 =?utf-8?B?SXZTbnlxaSt3S3dUMXFsNGsxOXY5RnNaSFFESC82dWFGRDEzQWMxTVRxZVlj?=
 =?utf-8?B?SGljcnZ4eHQyNW1QTWpNUy9xcENWd2pRTXdqQ0E1Mm5wSVN3WjFFbDdSbmN5?=
 =?utf-8?B?bTdkcGVibDRRNC9iVnBHUlFQdzBQd1ZQQ2VZLzhLK0dVNStFSVQzZC9taE1p?=
 =?utf-8?B?Vk9nbUt2NmpMUjVweWZSRnpORnFLWjRIV2ZmUlFrT09CbmhlSEI5UjBCWGI3?=
 =?utf-8?B?dSt1RDQrSFVrbFBYanM2eGEycVN1TGdoY2NvY1VrakpSUzVwbDJLNVBwZHd5?=
 =?utf-8?B?Qmp1VDRWUU5RSjFVTW9ING5KK1V1K1ZjVHlGOVU0TEJLcTdSd1lDSENzdVh1?=
 =?utf-8?B?bTQvWktjNmxZd0pWTkVsVUc4Y09PSkVMc0V0NGxqaVZMVzhOOUVWWG82YzJv?=
 =?utf-8?B?a3NqZTBlUXVicUdXRVFhdWYwVTZVblZzblhveXVEZTlSWEp3VlgraVBDRDRM?=
 =?utf-8?B?bE5WbWw1Mjh6YkdTWVVSaDNSU0U4UDBUd2tDQ1Y1NExBcU9abklsUWZ6eDFG?=
 =?utf-8?B?VHY4bGFVR1k4VFR0SlhBWW5mRi9lMTlmQnF1UUNOZy8wNWtZalVvZ1pIRnFu?=
 =?utf-8?B?T2NCcGVjdEt6ZTE0cjltUVhlZDVQWGJUVWJ0ZVNId3VOZm5PTzREZFJ3akJK?=
 =?utf-8?B?UW80N05tTk4yOW1PamVScnEybzFKbXRiNSs0VC9nZkF1NFhDWnNBT0hTWWpR?=
 =?utf-8?B?VnkzUWVZT0FiUG1IVW5tbXhhL3lYNUdwUC9hUmFUd2lNUWM3S0NXbEJIVnVs?=
 =?utf-8?B?dkpEWmhpY1pBUFk0L2t1Y2sxKzQwVUpFTDVYNHYraEwzVzFtalI5QldCSDhk?=
 =?utf-8?B?OXMycnVKMnUvd0lkUWhTMVdPOEcwOWNVRnZ6czM1MnZ6VjFJVHY4ZHptekl4?=
 =?utf-8?B?dWxrRGNQbHVueE9OUHkzcTdSYmw1VHlVQ3RDdU42VXhnV2taNXIzclhnQ2Y1?=
 =?utf-8?B?VGpuYTVneUFWT3ZHakswY1JlNkdnbzdZU3RvV0NZZ3NrcWlYOTZmL0g4ZTFT?=
 =?utf-8?B?QSsxYnBtQmovd2dpR244UERSbmJnci8yamF1ck0yRVo5LzBZNGtkTWcwNHcy?=
 =?utf-8?B?TG5temp3anRuMlQ0THNpNGcvdDFESGZPWXMxVlRURVliMWg5K3dqaE9GclFX?=
 =?utf-8?B?cEFqQ2pTb3pFbWJvanlscnFuNHNMODZhUmVoaytSZlZ5b0Rub3ZoZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437a23a9-6204-424b-9db2-08debe528477
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 13:51:15.3855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM83AVog3EDhFAh+hOmiFyf+oQK30nc9dhParL03Z6YAUxUeyQE3MPvGZ06UBrtk/LgYkBuzhKx/RNIDTQexMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3729

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 646ebdd3105809d84ed04aa9e92e47e89cc44502 ]

We have to report ENOMEM if no buffer is allocated.
Typo dropped a "!". Restore it.

Fixes: 50acaad3d202 ("media: rc: ttusbir: respect DMA coherency rules")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Unclear why this failed during auto-backport because it applied 
perfectly to the affected stable kernels. Just 7.0.y truly fails because 
it does not carry the buggy patch 50acaad3d202.

 drivers/media/rc/ttusbir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index dde446a95eaa9..83d206c3795c9 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -191,7 +191,7 @@ static int ttusbir_probe(struct usb_interface *intf,
 	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
 	buffer = kzalloc(5, GFP_KERNEL);
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!tt || !rc || buffer) {
+	if (!tt || !rc || !buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}
-- 
2.47.3
