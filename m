Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A935F5E1;
	Tue, 15 Sep 2026 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449190; cv=none; b=slpiptNotl6lpMcyMt+ctdDNjLOwDvSnx1Ef60CHICfKMVLIgxac/AIILO1l6EMeH6QpgLybP6VlyPRmwuPTd+hPpViumnEjCXTmtlP9NtTABLsNJ4N1EWx/B0u5Ng0JNDANFnqtPzCFfPSNg8UuV1p+k6fTS86XlOeJpp3KvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449190; c=relaxed/simple;
	bh=aVSn3+SZhX1Sac1jjscci9lTm8VMaMFL99YGtDXmsj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrPkKuPq7t9SSFPrkDZ+KEF+lUd0Ub/CxC+Qcc7AkpuwKD8IXlOxs8smE4Y7Cx57uyAmUnUTpO4vqphOqW4DHAL2JbPTUJfYxPgFGAbINBsaxwfCawWFqDmrPUskgUjdO9JdFcw3E10g7Ugyi3jvOEzLlVQ9fJHWdyLIKBUb1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=obfux4HN; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="obfux4HN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1789449186; x=1790053986;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=tnXNjj7lClz72+wluQ0IYjFHS/ljWRqHZho3KlUBhig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=obfux4HNOoxPa7LZcyZ+QVByD0koUoEmCW4swngYuGOkGlnvqQk+182BkiwAOtbo
	 bB4rwZngYeEEJoxpxUILuiH/gjzMJxH5QNB8Pscz5VqsOOfndH3UXBO3SRiQUFQsc
	 J9qhhu8mzq6TQ2LYejgOZrptVRjq65eu1M07gwGJHwV1pFOn2+DWpJut2YeqHWwYd
	 Aic+aPHZOWs5pA5UTmq1oCV1CUwdboOWCHs2zc9OS2Xyp2lIQy1MpFmjcY85GtT5Y
	 qD3cvvn5kTo2OlJx0fzed24HdUFyVySArVW4eX9AIflvUwg6tggAxKP/u6sic3MCV
	 mn9tdFr1mulogmW7MA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MkYg4-1wNhi73Qp4-00fVnZ; Tue, 15
 Sep 2026 07:07:25 +0200
Message-ID: <0ce929dd-1512-46a5-8d7a-eb1052faa32f@oldschoolsolutions.biz>
Date: Tue, 15 Sep 2026 07:07:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
 like qmp-combo
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
 <20260914-ps883x-disable-usb4-v2-1-523c32b4e4d7@oldschoolsolutions.biz>
 <b96659e1-d2e4-4272-8e78-8042cd5bca9b@oss.qualcomm.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <b96659e1-d2e4-4272-8e78-8042cd5bca9b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:12TAmqxyjk9ZHXoob95i7ait23dbNufMnKytaFl9Gr2QNtN7ECj
 fUZTd0sML2u1HGZeFj4gemke8ScmlX64y/LZ1IRHohMksfs8p/DU6lo249KC8G4fjdT9xrg
 tRYC2GMQ9tIgcym9qB1iFPWQ9nqOvtZ/pyiTb7ujvM03zrxIU5ODmON7xppaD3odfMO70Y/
 SSIw4QpisBtgRKW7EbECg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:46liG5Mj5EM=;uMlfOJyCpH1i76HUwte/X/+WRQJ
 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

Hi Konrad,

On 14.09.26 12:25, Konrad Dybcio wrote:
> On 9/14/26 8:05 AM, Jens Glathe via B4 Relay wrote:
>> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>
>> Several docks, including the Lenovo 40B0 and SSK SC220, still send the
>> legacy TYPEC_DP_STATE_F mode request (deprecated since DisplayPort Alt
>> Mode spec version 1.0b).
>>
>> Keep the handling in the existing DP altmode path in ps883x_set() and
>> mirror qcom-qmp-combo: pin C/E are DP-only, pin D/F are USB3 + DP.
>> STATE_E is grouped with STATE_C the same way.
> The premise here is entirely wrong, you shouldn't assume wholly
> different hardware should be programmed the same way
>
>> Assisted-by: Grok(xAI):4.6
>> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>> ---
>>   drivers/usb/typec/mux/ps883x.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps8=
83x.c
>> index 64e0a61b776a1..c185d8897e3a4 100644
>> --- a/drivers/usb/typec/mux/ps883x.c
>> +++ b/drivers/usb/typec/mux/ps883x.c
>> @@ -205,21 +205,24 @@ static int ps883x_set(struct ps883x_retimer *reti=
mer, struct typec_retimer_state
>>   			cfg1 |=3D CONN_STATUS_1_DP_CONNECTED |
>>   				CONN_STATUS_1_DP_HPD_LEVEL;
>>  =20
>> -			switch (state->mode)  {
>> +			switch (state->mode) {
>> +			/* DP + USB3 (pin D, and legacy pin F) */
>>   			case TYPEC_DP_STATE_D:
>> +			case TYPEC_DP_STATE_F:
>>   				cfg0 |=3D CONN_STATUS_0_USB_3_1_CONNECTED;
>>   				fallthrough;
>> +			/* DP only (pin C, and pin E) */
>>   			case TYPEC_DP_STATE_C:
>> +			case TYPEC_DP_STATE_E:
> STATE_E must not set the CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D bit
> I don't know if that's the case for F too, possibly.
>
> Setting DP_SINK_REQUESTED seems to be valid on _E.
>
>>   				cfg1 |=3D CONN_STATUS_1_DP_SINK_REQUESTED |
>>   					CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
>>   				break;
>> -			default: /* MODE_E */
>> +			default:
>>   				break;
>>   			}
>>   			break;
>>   		case USB_TYPEC_TBT_SID:
>>   			tb_data =3D state->data;
>> -
>>   			/* Unconditional */
>>   			cfg2 |=3D CONN_STATUS_2_TBT_CONNECTED;
> Stray change
>
> Konrad
Acknowledged, copy/paste debris. I refined the patch and tested this one:

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x=
.c
index 64e0a61b776a1..a5696aef054ee 100644
=2D-- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -207,6 +207,7 @@ static int ps883x_set(struct ps883x_retimer=20
*retimer, struct typec_retimer_state

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 switch (state->mode)=C2=A0 {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case TYPEC_DP_STATE_D:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case TYPEC_DP_STATE_F:
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg0 |=3D CONN_STATUS_0_USB_3_1_CON=
NECTED;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fallthrough;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case TYPEC_DP_STATE_C:

This will be in V3 with a corresponding commit message.

with best regards

Jens

