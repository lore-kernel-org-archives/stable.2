Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794020256;
	b=sIfCYKSmDAPWbL1FoFLZxCPIJwFXcyeCOds1dHREoiSO+I/OJNGLQ+dpTGEUnDfgt9sC
	 4EI9DfDnHiqW5/B2qfBt+Yf/PnQS/NqUhhJXXB9TIBPLoEDsCD0jC8q4Lj/ZVq2EQq/d0
	 +1hqHsj2ZShV4ymRqdVKX5u8TzxY+u8JZg1s9GH/4U3EwPH8AgDa4S4ymXuCTaKqFXyoE
	 vuDhE9f9h0jImVtD/atrmOXiFoT26MNRKXPLU7JaYjX8xaO8NIlYW91OlOaH2BwpBolBX
	 w48ORZAzf96fFBxhzsFOsMGTGVYGxoa6cRJx+AsJu28/pEMt4ObEKij2n/Ftgcm6bbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794020256;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=+NfG3aoVVDYg320wMNuDSmqyNFEaM7V/GRWW/LuOKlc=;
	b=OnFnA8BqFXKOFHVBMv+L7N84Bl9pteweYW1KKV9xEy/4G7wybRwNDOsnXoIlqy4lryzg
	 sGl8tF33HzWQhSI78NG3qdkczSEPuU7I85yXMD3kPcGEAmLEW3HB4+4JJqAG9g/sVXTgj
	 ZL14WqByq+oJqeL7uainn2KOcRvdOH/GOwzFWzoaG5Gjy7r2AQdOjovrBB93ZlffOJ3kJ
	 0AO5taD7AZfJTXxMxTDSrHWkW0mqVXyFCsbbqyWJLKnTP7+pXXOqlktfEMM9zeFI/Hkys
	 RFfdDaImwt7MKNX4mJ5WB1BgnqNiElWgafZ3m5afbXUH3/Q25qDY2lbSw9wfxmnhAYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=MDRyLQRw;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E9606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 02:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 795E9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=MDRyLQRw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794020248; bh=+NfG3aoVVDYg320wMNuDSmqyNFEaM7V/GRWW/LuOKlc=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=MDRyLQRweWcf+xUdMyrRKSmQ4ym8LxPSKGEuTbq8sda/LnBrQsChWSTv29ATNeLl1
	 5kWV0jo2YqJvU6DKgoUr+AJrGje3BPSoyvyrUwYRyCseF+TMcqFg43W8vPcKoVyG/T
	 IgribdMGCx+0gdmxzvXarCy4BkxVGjuwgdB5/LrI=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: MdmyWVu0InhASiUkhb//VhxE+kD9CHxdhJTc2eGlkCfKL+hSZzxtKPiKVMWgqY
	 Lv/UzTv+iDbo7dMZuvj8UN+79ox9/cI1AEMe33S2r7bt3E1M7gv8SGTY9I6pqBky60sk3/mm0O29D
	 v0tNVj8tRScQbUZinQwt1KFWKmyu1mcSFjpMRKY99eqQ2XcKYoS2kJBZ4JXHIhrufiW9AK7duvXRg
	 KsCUp8IMW+hWAen10Hz/NonxkHKmrw8902WefN6BT2pi5LZRVi6hT0uRjYwpmCFaBwOCVjazaFZkW
	 wEvJ2oVheUjYu7K2SVD3dwVH3rg8F1Ym9357Bt5Beoc/RzPFu25LZVECBn5HSGTziBRNIiIuN0BYv
	 dEY1lbfOgnkbsHmmhhBbM8zSlEo/FBbqBSFXTl0VIE558t1XIs5A0mDldpoYzntiRPQJhZW5ZJhQ+
	 aXfkpv1h/TX3CVwZKdOX088TERlmDzC1alWuo2aXUMAqKmn5cyZEA2Wx1M+jtxE7XQ9k+lBvG+1l3
	 Zq1Zh1i3lLMsxAXOGVv4s+FAEJn+M52EhPVreYm8frXOB6zR9f9VIq7AEjHL1lVVAPiG/jnSsdK8g
	 gl2D5ZEXeGnzyuJvVRK3zNJas9038c4pPTfTWudT0QbHKHcaiCsMBWWtcjr37NAAuyBE3cDToy1Ye
	 f/fPG5YwGmKcivHs3GSJKCOilYZAH/0NjqGLv3nOMYkIHgSrD4VBqR216mgFGUrYRlRoIglr8SnBX
	 Vwd9JgaaP0nTboNq8nqGOxkpMXE3N/smmQPyKgVHltVRYPhEjlLCfRnQDg5ahGRRGyn5xfrQC8gxe
	 1s2Xm/45nDEHVn54Il7wDgGZkucaaWxag1IMmsMYB5qNw+XLMaJV3txEO+bkf7nIXCmNSp5T74x47
	 JWyeAwNoPjkPUyKjUhtMl566EFDTKOjES7UsQlzb9uxvGRMYCqArnqRcqrnsawcwhe1woh2u7iiVl
	 juAaZyli3jPdvYY9zMs7UVjONkCX33DbPmQFGSBmrAvtZ92wlRp/O2VU0cnkVetSzWwX5d04zH20e
	 1OGx3SKWYgTJfYdLdBm+X0RZ6S74lhVe/Wnze8B3OhuP+NB45fbHc/8kqfCjn4GsLlGU6WyVm2SDO
	 tfRx5hWc/qYBDj4PUGmY2/bZ
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?SGVpa28gU3TDvGJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?RGF2aWQgUy4gTWlsbGVy?=" <davem@davemloft.net>, "=?utf-8?B?V29sZmdhbmcgR3JhbmRlZ2dlcg==?=" <wg@grandegger.com>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?RXJpYyBEdW1hemV0?=" <edumazet@kernel.org>, "=?utf-8?B?SmFrdWIgS2ljaW5za2k=?=" <kuba@kernel.org>, "=?utf-8?B?UGFvbG8gQWJlbmk=?=" <pabeni@redhat.com>, "=?utf-8?B?U2ltb24gSG9ybWFu?=" <horms@kernel.org>, "=?utf-8?B?Sm9uYXRoYW4gQ29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?U2h1YWggS2hhbg==?=" <skhan@linuxfoundation.org>, "=?utf-8?B?UmFuZHkgRHVubGFw?=" <rdunlap@infradead.org>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v7 0/7] can: fix bus-off restart and device close races
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 7 Nov 2026 10:57:26 +0800
X-Priority: 3
Message-ID: <tencent_B3369A1199D0849091BB8015C41BBFF0A607@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com>
	<16255046.uLZWGnKmhe@diego>
In-Reply-To: <16255046.uLZWGnKmhe@diego>
X-QQ-mid: xmsezb41-0t1794020246tqmnr7ex0

SGksCgo+ID7CoFRoaXPCoHNlcmllc8KgZGVwZW5kc8Kgb27CoHRoZcKgdGhyZWXCoHBhdGNo
ZXPCoGluwqAiY2FuOsKgc2tiOsKgbWFrZcKgQ0FOwqBza2IKPiA+wqBmcmVlaW5nwqBzYWZl
wqBpbsKgYW55wqBJUlHCoGNvbnRleHQiwqBbMV3CoGFuZMKgdGhlwqB0aHJlZcKgcGF0Y2hl
c8KgaW7CoCJjYW46Cj4gPsKgcm9ja2NoaXBfY2FuZmQ6wqBmaXjCoFRYwqBzdGFsbHPCoGFu
ZMKgcmFjZXMiwqBbMl0uCj4gPsKgCj4gPsKgWzFdwqBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1jYW4vdGVuY2VudF9DRDA1RjAyMEJBRkIyNTM3RjVEMUY0Q0JCNDI1NTg4RUE4
MEFAcXEuY29tLwo+ID7CoFsyXcKgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY2Fu
L3RlbmNlbnRfRTI1QzlCRTY2ODkyNjRFNDEzOEE0NjQ4MDNCODEwRkRGRDA5QHFxLmNvbS8K
PiAKPiBCb3RowqB0aGVzZcKgc2VyaWVzwqBhcmXCoGZyb23CoGp1bHnCoGFuZMKgc2VlbWlu
Z2x5wqBmcm9twqBiZWZvcmXCoHlvdcKgc3RhcnRlZAo+IHVzaW5nwqB0aGXCoGI0LXJlbGF5
LsKgU2/CoHRoZXnCoG1hecKgb3LCoG1hecKgbm90wqBoYXZlwqBzdXJ2aXZlZMKgdGhlwqBr
ZXJuZWwKPiByZWxlYXNlc8KgYW5kwqB0aGVpcsKgdGhyZWFkaW5nwqBpc8KgYnJva2VuwqBi
b3RowqBvbsKgbG9yZcKgYW5kwqBpbsKgYW55wqBtYWlib3gKPiB0aGV5wqBhcnJpdmVkwqBp
bi4KPiAKPiBBbmTCoGlmwqB0aGVyZcKgaGF2ZW4ndMKgYmVlbsKgYW55wqByZXNwb25zZXPC
oHRvwqB0aGVtwqBzaW5jZcKgdGhlbizCoEknZMKgdGhpbmsKPiB0aGV5wqBoYXZlwqBiZWVu
wqBsb3N0wqBvcsKgc28uCj4gCj4gU2/CoEknZMKgc3VnZ2VzdMKgcm9sbGluZ8KgYm90aMKg
eW91csKgZGVwZW5kZW5jaWVzwqBmb3J3YXJkwqBvbsKgdG9wwqBvZsKgdGhlwqBjYW4KPiB0
cmVlwqBhbmTCoHNlbmRpbmfCoHRoZW3CoGFzwqBhwqBuZXfCoHZlcnNpb24swqBzb8KgdGhh
dMKgcmV2aWV3ZXJzwqBjYW7CoGZpbmTCoHRoZW0/CgpUaGFuayB5b3UgdmVyeSBtdWNoIGZv
ciB0aGUgZ3VpZGFuY2UhIDotUAoKSSBqdXN0IGNoZWNrZWQ6IHRoZSAiY2FuOiBza2I6IG1h
a2UgQ0FOIHNrYiBmcmVlaW5nIHNhZmUgaW4gYW55IElSUQpjb250ZXh0IiBzZXJpZXMgd2Fz
IG1lcmdlZCBpbnRvIG1haW5saW5lIHllc3RlcmRheSwgc28gSSB3b24ndCBzZW5kIGEKbmV3
IHZlcnNpb24gb2YgaXQuIEknbGwgcmVtb3ZlIGl0cyBsaW5rIGZyb20gdGhlIGNvdmVyIGxl
dHRlci4KClRoZSAiY2FuOiByb2NrY2hpcF9jYW5mZDogZml4IFRYIHN0YWxscyBhbmQgcmFj
ZXMiIHNlcmllcyBzdGlsbCBoYXMgc29tZQppc3N1ZXMgcmVwb3J0ZWQgYnkgdGhlIGJvdHMg
ZHVyaW5nIHN1Ym1pc3Npb24gdG8gdGhlIG5ldCB0cmVlIHRoYXQgSQpuZWVkIHRvIGFkZHJl
c3MuIFNpbmNlIHRob3NlIHBhdGNoZXMgb3ZlcmxhcCB3aXRoIHRoaXMgc2VyaWVzLCBJIHBs
YW4KdG8gZm9sZCB0aGVtIGludG8gdGhlIG5leHQgdmVyc2lvbiAodjgpIGFuZCBzZW5kIHRo
ZW0gdG9nZXRoZXIuCgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBMdQoKcHctYm90OiBjcgoKCgo=

