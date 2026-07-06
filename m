Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226242F6F0
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352833; cv=pass; b=GwXORZ1mB+fOfXc8okJe07snzHlVX0CZbOWMS5IOtDKLyQXEHjll8hq6qewd1xHGTonj/FNvCEyIGgf2nB/4MiVSCzrIbvE7guujKEsO5LeStXDEJ4oXrCk71ybYLfUkb+Eqv94OFZwZo48YngQJs52XXEYw8EKAwyNRX0MwN4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352833; c=relaxed/simple;
	bh=ZK3umFUl4l3m+TbCatgyuRkELcarGJ4iocTqg7dKedg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/51BDFr4wJQU7P1q/M9o24eZ1bSRS3CUGHZ5mK8mSU8EFu1Y/sE6QA2OEN14IzKUTeXCtSR9Ug2V1LKVzPKJAQKZkqGUZh2yjIQaftJDl0r235aT0NN8IeSK/fAwXhTy/p3ImcoI8fjHAUtF284HDBctguIq8HYATw9Qf21cko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nct9fni5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hu7J1rG/; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nct9fni5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hu7J1rG/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFEPb972395
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 15:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9iQGNVUX0c+xixcxpD1Mh6//kGs2C0OMb65NaHkl0Oo=; b=Nct9fni5GyAQ2dbG
	XSC72Az4Wj83teMB6OixCxRi7MKkUOqYxqG1wqBWI7RwAFLxkAWboxxrRWjzQy8t
	niiXys+zQ3W/Uz+s+zkeWWOFQ8ILlTlRqX7wra/0PJirc+NEwoR2ARdPHNU8vZug
	sj/cv0izVU91jYOO4awJn/LAkirikLkqB5S2lHpIy20nsB6NvGW8DB4tUWZW5q6l
	ttnsgUe2ITEhHe274wUxsYP6iO9G5kxA/BxNWAjc3doZLys1BjTwhfBGIao7GHcf
	uUMRJEkJW5Nsy7Cy4g7gQpiEmTa7Ov7emW0di9o+IQoqtj0v31OSyDGVMbeqDtL9
	ax4YzA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r1hry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 15:47:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5fc4c7e9so349395885a.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 08:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352828; cv=none;
        d=google.com; s=arc-20260327;
        b=KBCEPlQlwVhwHsUOhsvIyXDI8s2LwzTrpd6E1vllUwOWLSduOmz3YJXCAd4OsuZXU5
         r/AxpRlbwLtZTecZW42Ea699rI3zqJzLr7SQ2iMsveJkw/kTQLbno3maODICWtf2x0L/
         fusYhr1ieGwml6N7fLinBNecEjBB6Gg1mmNN9qFEQCSAaPlxx1CaxBRSOoN7G8Od6td2
         khtDAltp8vwylwLxXciiSl/wpBBJy8125nZd+K/Vf3prt9ZcKhz/LTiaWKN0bcxqWHsz
         hDv5+hNCWTOKFoBFjtxchD/Lj562or/o2mj0Owtb2Dmjk1FKOM9tgbOhun3KXJJb8vuZ
         yfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9iQGNVUX0c+xixcxpD1Mh6//kGs2C0OMb65NaHkl0Oo=;
        fh=/2ODglu5idQIn/jOmWgje/t5WzAYM9RoWWtCbBCB+tU=;
        b=bJ9R4QyLIE6w6cG4XVdR01TNO98CkQnF+XQBdnMjmWfMSlw64X5JlvPHYRAGyDvm7+
         iKrJicHkvf1KIHlLDQ7n1IXqBuDn2KefjRCNCfUNIL6Qu/D9oQhoZWp74Wq3ASM3H95r
         pVO5d+0+gEcqsIObK4t1bncfP8R2N1L6Q34OXITlpQzobVohfZ/+bjNsR0HC/KEOLRIm
         +/5LEV7DZXa9h+oIGn4/ouUyd+Y51gWRTqXysoOjibd9UOThKP7sd36uq9aVUkjJ7ova
         sI7t6cC/kExzPLzgCljYkZuBHlp7t5ortgbQ4hEjTMtGIThMz4zjO+Qj6AreT5+oSB/B
         wPkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352828; x=1783957628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9iQGNVUX0c+xixcxpD1Mh6//kGs2C0OMb65NaHkl0Oo=;
        b=Hu7J1rG/nbH3wyFSBWchs95psI6LBeRfjMnk7wYZQI60JqPXXUorm1JxrQVLisKXE1
         Ox3xdkKjXYKwd24HH1jiFy3GTATn7+rBPyntpF7cadkJ+P41LJKN3ghMc1EVO072twTQ
         AbQImrOdwV0JxJYusrhJf+CQLHlBanPF87cJRPjg6iO1vEDSoFdYNxj2Mu8fwMiMm6Gr
         11lV1F+YK0WgbeIxSxyzXr6iyR6mvxpBdO3lj0AizmtSFBXH4mkOxYbUdMOtVjtsNZba
         W27zAyaLXaEAhZO05Y/Lq5n3aY9Qd0SxoLHdBnmZhMNQLKwn0zpv/lLvtVdwPfnIiShT
         STaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352828; x=1783957628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9iQGNVUX0c+xixcxpD1Mh6//kGs2C0OMb65NaHkl0Oo=;
        b=p5jSAugLpAbxMcamrHPo/ie/RQuOjyk25i/3UleU7wvW+v5T5rP53sNedmnjdJApjK
         +FG5gLTav2Udo1alLBAPVy6DkbSt9qt7prYXn1zGgplvJvBGx8FE5EInqEzkcQOqPj1L
         ziZy9xuU35We63d5eVN5NGsf2jyFdasCFpIqBp6KCbU/wJ5kPfJVSJDbrxGKoFJqvL//
         avYQWJE3hZgPzm9ij1bTV/0ZFzh2wSBzKlrJ3m4/7kaMWxSTEy0TwGgGFUUPrcV9TX+F
         cAvLcNNxVgMHI4bBf1Sgyw+FaO4oUJXmM1ljIQeczw+ou6yyg/Xkd2/HJlhdnvyjZBIG
         BAnw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0YvAfZ7EGZPYvslo5P7mb2jUmOXq8TnxpOhc9nK1mNcad/tvT/+9HRXLheqW56M1hGO620Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrfRxt+6bo9nRne7WylZDVht9GaWMLJGkT0IuxjApSHuoD5ub
	i+SHo5Hwv3R4mK3tXqsjE92qvc3b7ra5iSlffX5brWLQJUVtSABndJu/cMu/fwVPAnalCA8Gq+U
	uNpWLZvBqjwfyxhUdyp0c1DppZONeigxq3SwtE8U35W2fFEjJdbQkSXPq6Nbivz5u8gad5W77y1
	PHZqrK5IFy5mvujmq6q4tCJPNFcCeCXUyLgw==
X-Gm-Gg: AfdE7cm4rZl1DdSX97q25j1Qtc+c7DojV+ie0K691YY8Yu0zb6b/ti9Ged9sTTWIKqO
	b5y75kbrPSPJuNb4nNtJ9DmnG3zhodls9EtU3rJ/PR4FnyN2csAAx370paquP5eQePKrGO/ZuqZ
	MSXhVRHoePrX9qgpliGz2oUV+O1BgQWoXhKqrsBigCdumBEC0s5JpsE3WdrI0xqJdzNRYl
X-Received: by 2002:a05:620a:838a:b0:92e:72cd:325a with SMTP id af79cd13be357-92ebb534c69mr154355685a.15.1783352827696;
        Mon, 06 Jul 2026 08:47:07 -0700 (PDT)
X-Received: by 2002:a05:620a:838a:b0:92e:72cd:325a with SMTP id
 af79cd13be357-92ebb534c69mr154349385a.15.1783352827129; Mon, 06 Jul 2026
 08:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617152319.957866-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260617152319.957866-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:55 +0200
X-Gm-Features: AVVi8CdcWzNBLTglm0g3tUKG4yFhxoCahXMX-lM1N-hReZwTQgECqgmyYQF9Ues
Message-ID: <CAPx+jO_ZDDvEGueT-7EMHJst7qoZPJr_Gcnx1Qn3+KGpGjd39A@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: defer reset until cmd_mutex is unlocked
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Olech <tony.olech@elandigitalsystems.com>,
        Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXz/mtfZKn5iF7
 ecnU/GVnXleOVyen534VY1QnyyFNN5L4h38dyD8Udl/DLJyUT7o/TFHVVUg6xVnekjc+aML0iGA
 TKzZla2bpyzRNzrU0SgMGa7nqaKYQj6yKNNSxRpeGQCDv/pmdMYzD6aG/3M1qurVy/fTRS+Gytm
 mzjCkL1Ib5SvMHUhLlifiIYtbxP9HnkuF9Ejuyhx7q6gJCW6cC4e/nfEomYrUTZ4OLAfoPbtvSY
 kkBlgETpsNnfhLd/PQPNrMOOQ4q1EXs4NyXlE3wFJmLPyy2Af3BQocfBTXYvxyrnQh8ZMejHtba
 H/E8BffdblcO1d0jRj1kRmhPxVgWMcA76qKtR7taly68TyF4p5IoGn3hA3n0r9ezm+2lluzboUt
 uULF6tgZjpe5/bMM7ehhQ3e1CnHeVHk2pN8Bsid0DqJ5N3s7cvqluG/+Fn0fquHhBj/J8ZZsTT0
 F7QJPUma3h9LQxfBAqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX/7rDLGqT/0nX
 ww183uJvkMiNQRtiu27VH2FlAy3Y4MF+rxwzNtTW5TAtyGInv9sNvQcRkprkhjohgvmfErspEwJ
 giOKPJVr7y8EcFeWKBwvVVlyRn63TAM=
X-Proofpoint-GUID: GNQrkwOMf9eFhGjHip-wmzoonZ44rWWX
X-Proofpoint-ORIG-GUID: GNQrkwOMf9eFhGjHip-wmzoonZ44rWWX
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bcdfc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=ubNfKOfgc0bmnuDSWJcA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Wed, Jun 17, 2026 at 5:23=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> vub300_cmndwork_thread() holds cmd_mutex while it sends a command and
> waits for the command response.  If the response wait times out,
> __vub300_command_response() kills the command URBs and then synchronously
> resets the USB device through usb_reset_device().
>
> That reset path re-enters the driver through vub300_pre_reset(), which
> also takes cmd_mutex.  The worker therefore tries to acquire the same
> mutex recursively while it is still holding it from the command path.
>
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
>
> The grounded PoC kept the real worker and timeout/reset carrier:
>
>   vub300_cmndwork_thread()
>   __vub300_command_response()
>   usb_lock_device_for_reset()
>   usb_reset_device()
>   vub300_pre_reset()
>
> Lockdep reported the same-task recursive acquisition on cmd_mutex:
>
>   WARNING: possible recursive locking detected
>   ... (&test_vub300.cmd_mutex) ... at: usb_reset_device... [vuln_msv]
>   ... (&test_vub300.cmd_mutex) ... at: vub300_cmndwork_thread+0x12/0x20 [=
vuln_msv]
>   Workqueue: vub300_cmd_wq vub300_cmndwork_thread [vuln_msv]
>   *** DEADLOCK ***
>
> Return a flag from __vub300_command_response() when the timeout path need=
s
> a device reset, then perform the reset after vub300_cmndwork_thread() has
> cleared the in-flight command state and dropped cmd_mutex.  The reset is
> still attempted before mmc_request_done(), preserving the existing reques=
t
> completion ordering while avoiding the recursive lock.
>
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/vub300.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index ff49d0770506..1c335e070741 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -1583,7 +1583,7 @@ static int __command_write_data(struct vub300_mmc_h=
ost *vub300,
>         return linear_length;
>  }
>
> -static void __vub300_command_response(struct vub300_mmc_host *vub300,
> +static bool __vub300_command_response(struct vub300_mmc_host *vub300,
>                                       struct mmc_command *cmd,
>                                       struct mmc_data *data, int data_len=
gth)
>  {
> @@ -1595,17 +1595,11 @@ static void __vub300_command_response(struct vub3=
00_mmc_host *vub300,
>                                             msecs_to_jiffies(msec_timeout=
));
>         if (respretval =3D=3D 0) { /* TIMED OUT */
>                 /* we don't know which of "out" and "res" if any failed *=
/
> -               int result;
>                 vub300->usb_timed_out =3D 1;
>                 usb_kill_urb(vub300->command_out_urb);
>                 usb_kill_urb(vub300->command_res_urb);
>                 cmd->error =3D -ETIMEDOUT;
> -               result =3D usb_lock_device_for_reset(vub300->udev,
> -                                                  vub300->interface);
> -               if (result =3D=3D 0) {
> -                       result =3D usb_reset_device(vub300->udev);
> -                       usb_unlock_device(vub300->udev);
> -               }
> +               return true;
>         } else if (respretval < 0) {
>                 /* we don't know which of "out" and "res" if any failed *=
/
>                 usb_kill_urb(vub300->command_out_urb);
> @@ -1701,6 +1695,8 @@ static void __vub300_command_response(struct vub300=
_mmc_host *vub300,
>         } else {
>                 cmd->error =3D -EINVAL;
>         }
> +
> +       return false;
>  }
>
>  static void construct_request_response(struct vub300_mmc_host *vub300,
> @@ -1746,6 +1742,7 @@ static void vub300_cmndwork_thread(struct work_stru=
ct *work)
>                 struct mmc_request *req =3D vub300->req;
>                 struct mmc_command *cmd =3D vub300->cmd;
>                 struct mmc_data *data =3D vub300->data;
> +               bool reset_device;
>                 int data_length;
>                 mutex_lock(&vub300->cmd_mutex);
>                 init_completion(&vub300->command_complete);
> @@ -1768,7 +1765,8 @@ static void vub300_cmndwork_thread(struct work_stru=
ct *work)
>                         data_length =3D __command_read_data(vub300, cmd, =
data);
>                 else
>                         data_length =3D __command_write_data(vub300, cmd,=
 data);
> -               __vub300_command_response(vub300, cmd, data, data_length)=
;
> +               reset_device =3D __vub300_command_response(vub300, cmd,
> +                                                        data, data_lengt=
h);
>                 vub300->req =3D NULL;
>                 vub300->cmd =3D NULL;
>                 vub300->data =3D NULL;
> @@ -1776,6 +1774,16 @@ static void vub300_cmndwork_thread(struct work_str=
uct *work)
>                         if (cmd->error =3D=3D -ENOMEDIUM)
>                                 check_vub300_port_status(vub300);
>                         mutex_unlock(&vub300->cmd_mutex);
> +                       if (reset_device) {
> +                               int result;
> +
> +                               result =3D usb_lock_device_for_reset(vub3=
00->udev,
> +                                                                  vub300=
->interface);
> +                               if (result =3D=3D 0) {
> +                                       result =3D usb_reset_device(vub30=
0->udev);
> +                                       usb_unlock_device(vub300->udev);
> +                               }
> +                       }
>                         mmc_request_done(vub300->mmc, req);
>                         kref_put(&vub300->kref, vub300_delete);
>                         return;
> --
> 2.34.1
