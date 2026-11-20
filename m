Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795181996;
	b=NReXpSOSWD4eK4tz/ZANKYP2kjzODVUAO+3o2p2sa0I+h6Gl6n5pzLvyZROCvCPIJEWd
	 +kR7l3xs86cTrAs567CbnZ7pplwljMKxQnlrPzenVHdy01fcNIFkp+dUey7QF9SKX5JLj
	 CG37WJJgsfQkDzUQMrAdV5222fe5vM65bvB3fA+uLF2E/vUPLgg8naTJG3Dw9Lb0AgxR2
	 Bh6/uNLqfMq7dFPN+R8Ww1J78f+y2KGmu7DU8yfhsF13wuBpq1Jqq1+4d2+/O3lbxsl8P
	 HKQUky6HivkRQENuBKn78k/ncxtmt0AOE8Ol88NooTQeGX1vllmZlxguIvcCSY4cj4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181996;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=;
	b=zy4XhGWYPnz71vbMcrq2ZeiRjWBNRIdeCYwDkQcMtUnXUs2xN3qfBQpW//irxsZLb13z
	 E70eNnnzd5NviHreICXPihMz7ivnCZnv32mlAKVNNeFqqGhKfWfIbGtmdhHHCRM+XxsAo
	 SgGNcYo339Hfq1CPGf+mhZPQdjLYf6E6kAfk21xmpoq2EfWawkH7nLhBbyUNNNbaqPkav
	 NTT8K2c8kk0oYGWJohZaZVlGXeSwMrgW0AmqwY3kCc2yz+2z5lu46nrEk4W0AwNqumXJZ
	 vR/Zm73zHMcgssUUnRpFWq0QrhYl5k1XUDHp8tn/gTTVbpNo7c6xCvshNfiLoyFpd0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ks+vR7iC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gH6eyv1Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45331606A339
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45331606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ks+vR7iC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gH6eyv1Z
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKDZrkL1432297
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=; b=Ks+vR7iC0Clge7z8
	SvQ6m6iddv/cAiMHm5PvlZAwXCnYSHBBD9oXyLDBLyhgnrWlzBqvSlvZFSTF26n7
	IsSOcxGYyJ6an6d3PrTcZm/7aPWRsItbQdRhWC4cFU29gwSYLu20Ihh8W9LKP/nx
	79a4VC9fHjdBNMIFJ35mwZoyE0xkbB71sOdqeVCNcmmpx+GJqdTGjPqbcRVe4cqO
	AKrMMqW4P6c1C1jmuHO28JzzbYOtgLF4IPo5FcFsz1DbgzgWrK/RD2NKazv14qa7
	LefMfCi5D0uMoSb6lGxwOK6+WYGYy7ITeGWIAbys+Mib0dSDAf6lvn7xNk3YecjT
	E63yUg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fykwem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:39:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so194949885a.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 05:39:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795181993; cv=none;
        d=google.com; s=arc-20260327;
        b=ilGhmy2jQp6+qPNY597ud5pCKhz9Hu8OMKPVvGGW5ifkPpeaLwGZRRsrTuKcyOg41j
         qm3apaLyfaw2qGbAkCoqIaYK9FDbequCsO4ke1nYn4xCzV1PPn2GpiEpFBG7l9WpeRd5
         fsulGEewfkf3mMYuEfgCF6Ll1ieOtQMsDSCOavn5cNNtcR2P4fF8BWxmGKFwQAofl/Jj
         fKMTNTDarce82WJVqr4GjzStFDpbhpmHZLZYMKkQoVLEZaQPuh91hg4VKZ2nwMRozI9E
         0rH+3Bjhu1kzZF42vhG4/f4lUzmVrlF5acfWuWqZD8BeFiVPOFSr+7HIlX3GADoDQ8HQ
         v3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=;
        fh=Owb/LEcQb3SEiEdkmO8K0mFQTKo8j6ZG9sMDNmWdH7o=;
        b=UW4kmL9T6GFXez4KUf8YV5w9x2AJICe3H+znJtcMsZQGGOOqNHzNfmYbKzNhmwgjxa
         svbOrShcj78o+twPrWagk0Z4qyEeBjQzpu2unCKJtHEwQfLc9YofgzEQ5YVjXuMYMsQ/
         JIgrnu0XqTjMzQErHrVOkeG7nuDoPbaMO7GnIoErFdxsO/eEQLW96Utnm2oXTVb2HF/D
         +xpnL/OkQ4nVpW6SUKZH00rQJEsysbqUZqevvLP4eNM1CZDW1aNumum2+CItwRUh9ADG
         Y6rPNyBdmbnWf7Gx43efA2PP2J4LrGhM3QQ9j/F8nIgjxE4BySQb7ETkmZZvvHxtc58i
         YnsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795181993; x=1795786793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=;
        b=gH6eyv1ZC4qIyQO7+5eYFf2Ss01DCVVc8R4Wr45fkhie29q9Xki8R9BAmEQMR7uZ9h
         3odaNlmtRttWZjvz9Og369y7uPj3nv47hNLVtoieJAWmgN3cxxL1XH2tky2Z9xYqMtFz
         ORlx59ZcgR+A5l4YvlgIY4ux60RbFR/Q+3Oi/e1kdC98lWP3PkgtwZpoIgXmPb3jO5z6
         psH4CtKyf3JBjka9jiNFkwCB7RtgZXxX6GirWAH6iENnE7OdpkVUY7okQuC6zxkqR4H/
         xKdQ3pWq6avxltau/fa7v94GMh9mOfTOmQBuuGVkDzsM+AC6U46P7O0V6Ap4AHSbYzot
         NHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181993; x=1795786793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqMv/OV8MsEdJinmIa+2n6ss2Bycp38BjbJR4HiUnm8=;
        b=EfO5jpMnlHeq2u+1zsb2oCBrBrarsUynmgAkTHFSB6nXBNHCsav3d8/jeKuaKQjVBw
         er4f7K5+HBFrt65MAPjUtWlo7SbFKJJO0FII/TBq1WRsrC9KJjfcxcDY08GgOfZvXd9B
         m+7YFZNZMwEXhsnfu2o9ZT0qOpDr/1DtxvFmHychIoGk0Vr91aO0m3V7ctye0/8lXXxK
         i9Giw0GaIwaf/yCT8cI14MsWKU4qnPcsagAr3S3jeQKWE/t8KVlUdBD2vm5Q1W5E8v3K
         u+rcgWkrMp9bGgvK5Z+pkmCwekqFaNUMHmcVv6mqQjHgRm3Oxb6BfRdvZk/FSV5yRXTQ
         5Rgg==
X-Forwarded-Encrypted: i=1; AL+hErFe0mUR7Su8fxeJ+2bHZFoXgR7HRrjHOXUX/J1Au0UQJZSP2Ahu/XJ9xGgrdB8URyU+ROSzUWQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8l65dn6BL45qKRSvUBV0PsweAqqRnARpcBtmrkmX2O5QW80lDh
	osA55pzuKEP19Z3iSiGlnEovXt5/Qwfxc3+NRDCTyx1Og6NCyCGfapRDOP5VLQaJcJq5tfOvxru
	v6JjrE9MQesiJEJtjd/c/GHHEBFdWpE3rEK8aun8oO0pn+hJ6XnGNWv3AoKxFd1KaGDebZOCpjj
	R+UrE0qO4VmztNWpBgWZOB3hXklnBiEUHywA==
X-Gm-Gg: AYBFou2lMFH0kGUcCIAVNqbVKt6jIflw6GvG5Pq6rz1CcUQy8haAkJGw7HjJ9kaoDih
	1DqGle/hzd/M3B6MCe7hNq+Ivmv1E5VDe4bODcamX1Z4VOvzLVJA7ftZGb9pUiLaCXAc2w/iHBJ
	eE6+DoYcDLBp3Gc5RxNvT92/m+YWg5bQWMfk4/Y48OunhIOWw86gqRgBJHTrha3S3Zi/FHf5cUg
	2xIfPv3/cWn3mLQJ9h4X0PqYmuX3VDZfIr5lEHXqQj+kkkGckUYySmiaad7/MBt+Txzy7XOGd0=
X-Received: by 2002:a05:620a:2949:b0:949:673f:72ca with SMTP id af79cd13be357-949ba9b4a76mr483538685a.42.1795181993414;
        Fri, 20 Nov 2026 05:39:53 -0800 (PST)
X-Received: by 2002:a05:620a:2949:b0:949:673f:72ca with SMTP id
 af79cd13be357-949ba9b4a76mr483533885a.42.1795181992773; Fri, 20 Nov 2026
 05:39:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120062048.40310-1-enderaoelyther@gmail.com>
In-Reply-To: <20261120062048.40310-1-enderaoelyther@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:39:41 +0100
X-Gm-Features: Aa3M54qlRjeHgSFR1P3wHaYy6O8vflIlT3vP_wsr0HOLoZAnrHp26MLwOWOnWts
Message-ID: <CAFEp6-37+O4BoSL414Njogr-34G7se-8Nu+O7B0zjBY1Jw7UWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_serdev: stop write_work before closing
 the port
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael McAllister <me@michaelmcallister.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX6VSwavdhyMFm
 hq78OkjHb7oghargh6zhW5jGTfz1n7ZRA31/2wM3D7tiaW0tzqLYyhkb+kjUgweYmk3lk0UtA2m
 +XxUV91bGATU6Aq20nSS2oLwggz1WlU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXwASL4EjimPCE
 RsEeghIQu6kin2gjPDeyKVH03ybf1xqylyIuFo8tbFYPWVaUZ4kYuQtfpqA7nfwAdYe1qvZUxGo
 f5vEsiz5XaS/4m1Ywn6t1CDv7y2ZN4woz8I1KguAq15cj/mwJWO/kp+PoYzz8WavZts8kKhadTb
 shC/f6qV32VewtdFsom1q/+yIlxOWpBIeEu9/oyf+I20tCXMJmuAlqrfaO9flUmFTC9FoPgKWgO
 Ce/+Ao19QBcD2mR9fxAbDcZCqN+JhZEuVjhljW4cY4avNGZbdHuBq/YDxSj5R38vQcTbSIRRTRr
 Qr9++D81HLk4UixHkUJHuo5LU0m2CvEVEPKw5TLrNxN3dkwZjCCaIGWGeswf2GVsA7NdYw2e2K0
 oR6Iw9qEaTwAK6XCV7SRkT9dg5A3O3OY5v97hBofYT1kCSFY/mtfjEd9E2ErkodzYN/6wAMGH2m
 72+J7DBknf9w62syaEg==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6b004dab cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=gJp14KxlFVqSh94YCh0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 7iz8ayvehA0VGTQGe2PbIMGqedpzbtlh
X-Proofpoint-GUID: 7iz8ayvehA0VGTQGe2PbIMGqedpzbtlh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200054

On Fri, Nov 20, 2026 at 7:21=E2=80=AFAM Zhao Li <enderaoelyther@gmail.com> =
wrote:
>
> With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() clears
> HCI_UART_PROTO_READY without hu->proto_lock and closes the serdev port
> without waiting for write_work. The hci_uart_flush() just before it
> re-enables write_work and may replay a recorded wakeup, and
> hci_uart_tx_wakeup() queues it from any caller that passed the
> HCI_UART_PROTO_READY test, such as the serdev write_wakeup callback.
> write_work can then call ttyport_write_buf() while ttyport_close()
> releases the tty, so it writes through a released tty.
>
> A partial frame that write_work leaves in hu->tx_skb also survives into
> the next open, which flushes nothing, and would be sent first to the
> controller after it is powered on again.
>
> Quiesce the transmit path as hci_uart_unregister_device() does: clear
> HCI_UART_PROTO_READY under percpu_down_write() so that no wakeup is in
> flight, cancel write_work, free the leftover frame, then close the port.
> A wakeup sets HCI_UART_SENDING and HCI_UART_TX_WAKEUP before it queues
> write_work, so clear both after the cancel: a work cancelled while
> still pending would leave SENDING set, and the next open, which reuses
> hu, would never queue write_work again.
>
> Found by code review. Compile-tested with W=3D1.
>
> Fixes: de8892df72be ("Bluetooth: hci_serdev: Close UART port if NON_PERSI=
STENT_SETUP is set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> v2:
> - Clear HCI_UART_SENDING and HCI_UART_TX_WAKEUP after cancelling
>   write_work. A pending write_work cancelled there left SENDING set, so
>   the next power-on never queued write_work (Sashiko's review of v1).
> v1: https://lore.kernel.org/linux-bluetooth/20261118124821.3990-1-enderao=
elyther@gmail.com/
>
> Before 6.16 the quirk test in hci_uart_close() reads
> test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks); with that
> context line the patch applies to 6.12.y, 6.6.y, 6.1.y, 5.15.y and
> 5.10.y. It applies as is to 6.18.y and 7.3.y.
>
> No new W=3D1, sparse or smatch warnings.
>
> AI assistance was used.
>
>  drivers/bluetooth/hci_serdev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serde=
v.c
> index 194f11251cc5..a5e4b3d32144 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -164,7 +164,20 @@ static int hci_uart_close(struct hci_dev *hdev)
>          * open may drain the battery.
>          */
>         if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
> +               percpu_down_write(&hu->proto_lock);
>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> +               percpu_up_write(&hu->proto_lock);
> +
> +               cancel_work_sync(&hu->write_work);
> +               clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +               clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);

Looks like you are mostly re-doing what has already been done in
hci_uart_flush()...
Wouldn't it be simpler to have a hci_uart_flush parameter to not
reschedule tx on flush?

> +
> +               /* Do not send a stale partial frame after the next open.=
 */
> +               if (hu->tx_skb) {
> +                       kfree_skb(hu->tx_skb);
> +                       hu->tx_skb =3D NULL;
> +               }
> +
>                 serdev_device_close(hu->serdev);
>         }
>
>
> base-commit: 1d79f61152c315e30e758116e525871732181a98
> --
> 2.56.1
>
>
