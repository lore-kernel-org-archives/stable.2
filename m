Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260412;
	b=gyJFh9qt0zcDnT/bIuYgmqZFiIMRjx+3CGToyluAsG61bcOF2KABbcDM7ygjx/DVIeNL
	 67/3s5OBJaB4GiHJw6sEgdElulrGpi3EP3pcepl1KEv4hT88z+xtOK9Itk8mU2Bl+/SGn
	 gTW0CNK1+6QG/lkBscutD0BmFMB+rNl33qtk8gPKB5xbiil9T6m4RAB5zM2U629XgCIlB
	 h9Sh4X9HN7cgkwsOJAQwoiMl19Lm57itrcbGat4KIAzLB8RLQgCFs7jAhCXD3Gs/76nuq
	 24WwLm+DfudfbiJ0tJcpkMao5IodlPOj54KiwEBvhhnjftPffznFnlnEJKPmzA06Erg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260412;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eUnUJ6fMsa+SK3hUNyUAZu2gmdqYdOP/pDefbHCAe7Q=;
	b=WvVEwhpWg3IoBBfyADVgkn7oAjKAcvsZ7uS5Q2qZr6j48QvH1vTvBLo6RhPFIAvk+JPV
	 Isk7TApT+b5gRF5njrfRvxwwM3jihxEtNquoNqC4trtm8Y0qxUPNutOzlHAd4lMqZt41H
	 u0ocYLTS2Pm0AhgdiEgsoELdgeG/7rQw5hHKtzWS/qDPBm/QJqtrIF07siOZSwbKEez5k
	 OidV2UcDbGVjdRrCDW3M09opQMbnrxO4bKsobvS0FFYrLcFcH+7ivY+ZaCpJvrrle5ZBL
	 fkxqpGjCWkr/Enu7cn0dQD4txT+RYoNlaGfy+7lr1lETo8dY7SAMyYRjGtVwXp0yNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=GWRCBtmQ;
	arc=none smtp.remote-ip=91.218.175.64
Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC97606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 21:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FC97606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=GWRCBtmQ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y3CmxKJ4TKlJACzMuZuQE+pA/o7Ia4zpMq+sD48qZJQ=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794260407; v=1; x=1794865207;
 b=GWRCBtmQ8mQYqYbx8qdefLwaYDeQkj6VU+gg+PyNgDeOrXtjguyx3KNB7CTPF/zOtqRYNwrs
 4ciJtPtsELFhHUBvUQUs1KIV2SpouXMAbkbf3sqRUc2+efELrQIdf/UIBPGoDuQWOJS+pUBOVCJ
 HH0u4ZyRwQflY3uWqqBGL2TAllhjLxVetGpOfE7ABqmZCRGyiZg+Rr7Dy5pr67QSBWtF83vcpvZ
 K0np02SDI0EFTWLZo8cTDNz7GQUap4fznYeR+Gz/XKIZHWRxED+4bNNY8UjpGmZodqfCbhZ8UHs
 bEdCicMvjwNqMBeQ15UfC8PIVVLJ71ObR8U2lgonIclaw==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 91629022a1c960c4;
	Mon, 09 Nov 2026 21:40:06 +0000
X-Mizu-Trace-ID: 91629022a1c960c4
X-Migadu-Flow: FLOW_OUT
Message-ID: <25204208-5fcc-4b00-b359-86fc5f124700@packett.cool>
Date: Mon, 9 Nov 2026 18:40:00 -0300
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: qcom: pas: Request stop before tearing down
 GLINK and SMD
To: Jure Rebernik <jure.rebernik@luxonis.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org
Cc: konrad.dybcio@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261109175752.793130-1-jure.rebernik@luxonis.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261109175752.793130-1-jure.rebernik@luxonis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 11/9/26 2:57 PM, Jure Rebernik wrote:
> A crash of the ADSP that the host reports, for example through the
> remoteproc debugfs crash file, can reset the whole SoC on QCS8550
> instead of restarting the ADSP. The reset was most frequent shortly
> after the ADSP had started: on two QCS8550-based boards, crashing it
> about 4.5 seconds after it was started reset the SoC in 19 of 42
> tries. The serial console showed that the system stopped right after
> the recovery started. Nothing more was logged, and the SoC was reset 6
> to 7 seconds later.

I've been seeing crashes in sensorspd like

qcom_q6v5_pas 3700000.remoteproc: fatal error received: 
EX:kernel:0x1:SNS_SEE_I_0:0x10000025:PC=0xf00280b8:LR=0xf001f>

on a Kodiak device (sm7325-motorola-dubai) also cause a whole-SoC reset 
right after logging that, when trying to restart the ADSP.

Those are somewhat random and not too frequent, like once every couple days.

I'll test this patch and see if I no longer end up with my phone 
randomly showing the u-boot menu when I pull it out of my pocket :D

> Since commit 0ea50486978f ("remoteproc: qcom: q6v5: Request shutdown if
> crash is triggered host-side"), qcom_q6v5_request_stop() also sets the
> SMP2P stop bit for a crash that the host reports, so that the firmware
> takes part in its shutdown. The stop is requested from qcom_pas_stop(),
> which rproc_stop() calls only after all subdevices have stopped. By
> then the GLINK and SMD edges to the DSP have been unregistered and
> their client devices, such as FastRPC, torn down. On QCS8550 the ADSP
> firmware treats the stop bit as a fatal error and runs its error
> handler after these links have gone away.
>
> Add a subdevice whose .stop callback requests the stop, and add it
> before sysmon. Subdevices stop in the reverse order of addition, so the
> callback runs after the SSR BEFORE_SHUTDOWN notification and
> sysmon_stop(), and before SMD and GLINK are torn down. The firmware
> then handles the stop request while its GLINK and SMD edges are still
> registered. qcom_q6v5_request_stop() still skips the request when
> sysmon got a shutdown ack, or when the firmware reported the crash
> itself and the fatal or watchdog interrupt has cleared the running
> flag. It also clears the running flag, so the call in qcom_pas_stop()
> now only sends a request when the subdevices were not started.
>
> With this change, none of 104 host-reported crashes on the same boards
> reset the SoC: 40 ADSP crashes at 4.5 seconds, 20 at 4 to 15 seconds,
> 20 while the ADSP was streaming IMU sensor data and 24 CDSP crashes.
> The ADSP or CDSP restarted each time.
>
> The problem was found, and this change was written and tested, with
> the help of an AI coding assistant (Claude Code, by Anthropic). I
> reviewed the change and the test results.
Try not to provide the free advertisement right in the commit msg btw, 
and to make it sliiightly less verbose.
> [..]
> +	 * Subdevices stop in the reverse order of addition. Request the stop
> +	 * after sysmon has asked for a graceful shutdown and before smd and
> +	 * glink are torn down.
> +	 */
> +	pas->stop_subdev.stop = qcom_pas_stop_subdev;
> +	rproc_add_subdev(rproc, &pas->stop_subdev);
> +
> [..]

It looks a bit funny that "stop is a device" but well, it's not like I 
can think of a more elegant solution…


Thanks,
~val

