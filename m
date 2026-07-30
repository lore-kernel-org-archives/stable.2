Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62583D3337
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403032; cv=none; b=X6H8VRQU9h/vcI9v1atac7Jayhvnufc9p97a0+1T/Y51lwyrQtfFohLxWO+43SQ+ZjX812CVueRhmVJb8J7vJapIe1wOM1RC3O5vLzhQxNnceIoZFHhQS8SwhhJhq6PSbtfilBDpWkxl3UVdP1JwHpndVc3TtlEPOqfEFau8pYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403032; c=relaxed/simple;
	bh=FZ81sEKa0AGlUh3qOMslFSdN4ZIgzNfOwEBmjr2Kigw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbjzkHadSawpklwyvCNnpmDyuZVZ093TmgIkUtPOEm7d+Z4OIiA7diJyqRmEXBXuWw23cgFfFheFdKwkOR9n/om0eqrTDXHupe4e/tIWvVPFZiYUO98WEs1tG4ZnEqqx+CJ7mfR+WWExbXbuVhNUM64UCYhbF+j9p1+mDqP6mVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKlObpXO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FoJIOnAb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKlObpXO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FoJIOnAb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U9CZw4619173
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sg+tTmUjvICwaDYn2CXixJNQI5H+8IfxBQw4flH87tw=; b=pKlObpXO9v76hLMy
	gX4ER4IbpwRdL3T5OSejLFUujzwevHaEtrcktr/XI3EitwaiKjJL9+3nVxLEeFT4
	eM7aE5A8lzmjSga7iCo7xHpFNQt6xFDBOefbVAdsLsntSlQfjw52/kCvZqNmfYpT
	uFs5gfPzvqN4RBvaO/eNXjdVJJfxwbwxkgnGdPYUaU78tcBuAizfN1jq33lvJuIq
	gzeNar1FqfK0QrBA/9IX+ZCTNyoi/Ok++yNZy3LbpaUNwwJVMs5u82w0cedIon7S
	OvoRI3UQilym/yQaURD890J1VEMuX431XkVjhmRlaHwng8vAzccTh4C7tkdId11M
	hLdPMQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3sd80ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:17:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so5560645ad.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785403028; x=1786007828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sg+tTmUjvICwaDYn2CXixJNQI5H+8IfxBQw4flH87tw=;
        b=FoJIOnAbzIOj81GmSUK6S+osqbWFJVScybPNzRHmQjza7TDZJWx0D8b1zQadXGLPmF
         mdcBsfigHDS7Ce1YVDAJhlARMPKVzxBtG8+YvJtd3eHSTnls6DmTFQfH1c6d2as+m1+L
         r1mblYWFyt52fllLpl9bcqHGcBWVjtv+AKbKkjmRbAJy0yXcXpI2g3l/JVLa3IGcmkHV
         fmRWrLlUgYhFaMXsMv7D4OWMdgX6WlOb7PyzENYvZv5AsRDnQkVu6Wh7gXIQzii7kM/C
         vxYBi7KlzIqT/hOpz8c/nraWJlP+7mLhE/0VJKR+PTaMyiGNtEF5w1LCj+vWH0d5HoQM
         fJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403028; x=1786007828;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sg+tTmUjvICwaDYn2CXixJNQI5H+8IfxBQw4flH87tw=;
        b=O7Pdo5YDwNf3REiEzCfhQMqOVr2uxe2dPEhojfQYylj7wcpC9iahk/+ONn0W21gD9F
         7dlPoV8Or3TlTv0AxvZ+y4E6xz9aaNNtIZhmc81Q69RBLaT96uBiDD+pb8lClJpa2Hjy
         cVeTgbN5xzj0OkpjIn7sW6RCisLLySgWVgN3NtkvuKGRuQ9Fzw36tOl+yey7/O2rEp7t
         73CZP0MfhaDzr8YryiDfE/1UDDt62rv9l24r3/SWoi/v0WUS6yGJFu1KeqqkaqU0GwHj
         8tgaVKkxovNkrrobJyz3eo0Wd/uBhgz8ux8JGK9hflHQfO96fMygyQikr4XhS8mNvQ/R
         u9bQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFRnDAcc9GZQVsrMXAwQQ2qo/UKTQ2yNlHmCdCSmMBytuer9pff4RsFUBTGc1VOoVS8Y+AXmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrr/HOSzmSe227NRaBV7J+AmSy8cJqJHkAN5kZXgzRF4IXDoKl
	U77LaaRQ8kiYlXZJle043pvPYmjb4aZIRD1p5qo0HyXukfG7i7qiJwLilnthoIU9t5ijNof77+M
	Qq8z9JJ28mbEcR59cL8cckCUGmf9sQw5m3Ael4P+qK9pEr0GQlWjJsEL5by8=
X-Gm-Gg: AR+sD13HQq6M1bBQK63OGzjAlflRmrxt89ZAw3Q63/od53pO21nbcc5qQwbZ7UclkER
	wwAAKpXkuPZTCOgTFWVTOMajwCsZ99JnXOG0NeTkKtsDA5DBH7j0OXUeQYdb5nxFik0c/AHgurt
	hfB6DrCFYkvMWIvn2XBs44BKcDlZB4nvLIYK0/Jg7UXC9yav0cSne/yeyY3CCIuZeAb7HkpkXwe
	3IrBu/Yhnea4jMDJOzELJ1E32BkDa0Wb37phGsBmOn1rpA3583B8sfynecfTbB33Fmw0CBG7vSI
	USqhntDIAL0YB61vX6kpo7INOGTDVa3s+FAwUUp1qo9BOU+DP5Rhkp3NqL/lSR/FwIo3kuC0GQz
	2JOe0F8OHV9oUOy5+7OkzvQ44RVy5HGSx
X-Received: by 2002:a17:903:985:b0:2cf:18e5:1d18 with SMTP id d9443c01a7336-2d03709445bmr14082905ad.29.1785403028353;
        Thu, 30 Jul 2026 02:17:08 -0700 (PDT)
X-Received: by 2002:a17:903:985:b0:2cf:18e5:1d18 with SMTP id d9443c01a7336-2d03709445bmr14082545ad.29.1785403027810;
        Thu, 30 Jul 2026 02:17:07 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.104.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc8400sm23245535ad.47.2026.07.30.02.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 02:17:07 -0700 (PDT)
Message-ID: <09c45fbe-f8f7-48b8-9385-2b02ed2b63ce@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 14:47:00 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] serial: qcom-geni: fix TX DMA buffer flush
To: jaseg <git@jaseg.de>, 'Greg Kroah-Hartman ' <gregkh@linuxfoundation.org>,
        'Jiri Slaby ' <jirislaby@kernel.org>,
        'Bartosz Golaszewski ' <bartosz.golaszewski@oss.qualcomm.com>
Cc: 'Viken Dadhaniya ' <viken.dadhaniya@oss.qualcomm.com>,
        'Zong Jiang ' <quic_zongjian@quicinc.com>,
        'Krzysztof Kozlowski ' <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?=
 <linux@jaseg.de>,
        stable@vger.kernel.org
References: <20260729174105.21838-1-git@jaseg.de>
 <20260729174105.21838-2-git@jaseg.de>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260729174105.21838-2-git@jaseg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: repLv-9WPZyZadADc7sOOpmDM4ugNkAM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfX3GOLBAvBJ9ba
 AjJOki0MmgqXee/PfRav0482Dakl6VhO/5d7nG+2btMS0whhusDScc3MPJFxyjPVs2S3XGfY7YA
 SkGWRp3tD4uSA+W9yqeZJJUTPE85V1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfXynLpDg0aXIje
 2FS9lMi2aucdvPFG+fjJl6BtEb+vpc+vKvxYT84zUcEneERVf/1OJflIYp0Jv3QQzh79lyq98xx
 SB7TZfrjcobPzHcowqME7pGobuN+pMisM6K+OmqzB3bM2N3mN0y/vUKpEo9PRAyAEPin47rdZwC
 wGN+K+ZSoKBnY5crNzljNWVS6Tqvh6vmpJremaW1LPbFpQ7QEDfSUBJfL+02oYpA+pX0J+v/sEg
 DfiaE6m4a5jf2K530tCum6vyExXBWnsZBvOJKy72V3SgBvBB2QDvxbXIqOccfCfIgAldoc0Dy+j
 FgJkKAGNJCFK8OOOHepXqjiFFchRPxDhLH0dyQOuBTu8Y3nK5onb+Kbm6UcpvFxjEugOqmE3n+d
 4L9UTxjuFJ09+TNkskWWF927c+3G1lNbNnBb+zvbgPi4WikcN7JFQRpWS/HEGuE11MPJ72PSJbY
 EfJ/mrvHMBao77Xp4Sg==
X-Authority-Analysis: v=2.4 cv=OJ8XGyaB c=1 sm=1 tr=0 ts=6a6b1695 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=P6HVPSMEYUq+RwDLB+OCyA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z8m4AokP3hRY3N2J9A0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: repLv-9WPZyZadADc7sOOpmDM4ugNkAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300068

Hi

On 29-07-2026 23:11, jaseg wrote:
> From: Jan Sebastian Götte <linux@jaseg.de>
>
> When transmit flushing a qcom-geni UART during an ongoing TX DMA, the
> UART gets stuck infinitely repeating corrupted TX DMA frames.
>
> The DMA-mode uart_ops does not provide a flush_buffer callback, so an
> in-flight transfer can complete after serial core has reset the transmit
> kfifo, underflowing its length and resubmitting page-sized transfers
> indefinitely. Add one that stops the transfer and clears tx_remaining
> and tx_queued.
>
> The stop path was also broken: it unmapped the buffer while the serial
> engine could still read it, and never reset the TX DMA state machine.
> Cancel the main sequencer command first, then reset the state machine
> and wait for it before unmapping. Drop the early return so a pending
> mapping is also cleaned up when the main command is inactive.
>
> The bug can be triggered from userspace with a large write immediately
> followed by TCOFLUSH. A following tcdrain will hang forever. The bug was
> reproduced and this fix was validated on Arduino Uno Q (QRB2210)
> using /dev/ttyHS1.
>
> Assisted-by: Claude:claude-5-opus Codex:gpt-5
> Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> Cc: stable@vger.kernel.org
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 43 ++++++++++++++-------------
>   1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 7ead87b4eb65..1e39122ec09f 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -158,6 +158,7 @@ static const struct uart_ops qcom_geni_uart_pops;
>   static struct uart_driver qcom_geni_console_driver;
>   static struct uart_driver qcom_geni_uart_driver;
>   
> +static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport);
>   static void __qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
>   static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
>   static int qcom_geni_serial_port_setup(struct uart_port *uport);
> @@ -636,35 +637,34 @@ static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
>   	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
>   }
>   
> +static void qcom_geni_serial_flush_buffer_dma(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +
> +	qcom_geni_serial_stop_tx_dma(uport);
> +	port->tx_remaining = 0;
> +	port->tx_queued = 0;
> +}
> +
>   static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
>   {
>   	struct qcom_geni_serial_port *port = to_dev_port(uport);
> -	bool done;
>   
> -	if (!qcom_geni_serial_main_active(uport))
> -		return;
> +	if (qcom_geni_serial_main_active(uport))
> +		__qcom_geni_serial_cancel_tx_cmd(uport);
>   
>   	if (port->tx_dma_addr) {
> +		writel(1, uport->membase + SE_DMA_TX_FSM_RST);
> +		if (!qcom_geni_serial_poll_bit(uport, SE_DMA_TX_IRQ_STAT,
> +					       TX_RESET_DONE, true))
> +			dev_err_ratelimited(uport->dev, "TX DMA reset failed");
> +		writel(TX_RESET_DONE | TX_DMA_DONE,
> +		       uport->membase + SE_DMA_TX_IRQ_CLR);
> +
>   		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
>   				      port->tx_remaining);
>   		port->tx_dma_addr = 0;
> -		port->tx_remaining = 0;
>   	}
> -
> -	geni_se_cancel_m_cmd(&port->se);
> -
> -	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> -					 M_CMD_CANCEL_EN, true);
> -	if (!done) {
> -		geni_se_abort_m_cmd(&port->se);
> -		done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> -						 M_CMD_ABORT_EN, true);
> -		if (!done)
> -			dev_err_ratelimited(uport->dev, "M_CMD_ABORT_EN not set");
> -		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> -	}
> -
> -	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
>   }
>   
>   static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
> @@ -1180,7 +1180,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
>   	uart_port_unlock_irq(uport);
>   }
>   
> -static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
> +static void qcom_geni_serial_flush_buffer_fifo(struct uart_port *uport)
>   {
>   	qcom_geni_serial_cancel_tx_cmd(uport);
>   }
> @@ -1769,7 +1769,7 @@ static const struct uart_ops qcom_geni_console_pops = {
>   	.request_port = qcom_geni_serial_request_port,
>   	.config_port = qcom_geni_serial_config_port,
>   	.shutdown = qcom_geni_serial_shutdown,
> -	.flush_buffer = qcom_geni_serial_flush_buffer,
> +	.flush_buffer = qcom_geni_serial_flush_buffer_fifo,
>   	.type = qcom_geni_serial_get_type,
>   	.set_mctrl = qcom_geni_serial_set_mctrl,
>   	.get_mctrl = qcom_geni_serial_get_mctrl,
> @@ -1792,6 +1792,7 @@ static const struct uart_ops qcom_geni_uart_pops = {
>   	.request_port = qcom_geni_serial_request_port,
>   	.config_port = qcom_geni_serial_config_port,
>   	.shutdown = qcom_geni_serial_shutdown,
> +	.flush_buffer = qcom_geni_serial_flush_buffer_dma,
>   	.type = qcom_geni_serial_get_type,
>   	.set_mctrl = qcom_geni_serial_set_mctrl,
>   	.get_mctrl = qcom_geni_serial_get_mctrl,

Reviewed-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Thanks,

Praveen Talari

