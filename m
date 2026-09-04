Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66C4483A1
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514907; cv=pass; b=f80wY95ig2AhFy66VBO0kkM+jt+k4/ZPjG4hFnUTftzZIQrIF1CCiOX5g5PjyHA2Qa3zMqKb94Xn7CiPiSNUdxFC4UYi1WrIsFlUZZZjPCLreRAveEbniSjTR6rfFhWceqldlvdQnxdUSytYh52H+X4In0fSypXm/I5KP4c7HZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514907; c=relaxed/simple;
	bh=oe/T6Y/FRUUrrhaa53RTdb7ccil+Ty21E42JRSBu4DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY0OcrUQdDYx6HDlruNQWP/fa5QSbLDbYSu7ugChIqyfcX0dJGu+cGRvbwcWPWEEKb9+JTqDsv4xY52bqErI7mNl4xJ6aL4gSvpN/LbhBhtEuyO8GuHTGbgZ/8QgfveZC4wsVeHrO1r5lJur15d0EVfGqaVOlMWVuiltIQJWwVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5bBjrGm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PmspViID; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5bBjrGm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmspViID"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mnsg2351549
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 09:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0CXHz7ekqSyyXlE66+G+z+OMwp8FaZS/VX/QUoLofYM=; b=R5bBjrGmPSFpV/bI
	QQ9W9eZhgi/X2GKxt7anXTR3RSx8Fjueac/1HKxMozL7D7UvLSPnjvasPwZxvuLe
	RvM6qmQxfPBxiojKvh2WxNWc7G4we5vRajEErTJ0Ga/JHvjtygDx1g7QAzFVmkXH
	3bjdEaiQVCaLm5ivqafBxa+vdOR8gmBmsJM4hs6x1fSECabeeCnuSGheml6p1z2U
	qzOoRRBK6QqkBWUZPJz62aQ44KDi29l+ag1nbxo84SV1ceCPDZtvfnzjRa6sIf+c
	8HAt7ay59PVDrh0TgiD3OKwSqaJrkSK0oOjO6iuMv3zbATdNCUs0gqky3c5xRYVx
	Y8itnw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp1fh4p2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:41:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1a439db36so976801a12.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514902; cv=none;
        d=google.com; s=arc-20260327;
        b=ZFlcc7bG34xx8l438voUtuThnob/qpD1W6OSfMzHDbBiccI/SDycGa6hJk80mtXGvz
         5oaeM2sFoIyT7x9A0FjgXZMXdExbuY9wYCzwTPVebZsVGg5s1s+aOvlNuIT8lMLlTOlW
         rO33ij6pFds0nT4deNhCf/4lH35D3Ibdc1krN2o2X6Y2yaYtW2RbkEeaERjbDihTPVtd
         vG0d3vaN2FYT4iJZD9DOJSgsslwQ/kAMs7KzUVjZzCfLI/Ge3tMPi3wM9QL16TyXt/cu
         L4jf7vGn63ELbzUloEyjGRuPuO1UFvqeJp48HmIGeroDNvGRPNCWK8D/QJcaWeiqX+6I
         ApVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0CXHz7ekqSyyXlE66+G+z+OMwp8FaZS/VX/QUoLofYM=;
        fh=nr+vyA9AfebxtWOzD913G38YT2rjr01mLeWv1Mek4Hw=;
        b=kHljQdeCBukU3HDvjnO+H02FiqbXCE/y08znQfPLX2/tREliQh9oV3DaPB51ZEQCyh
         qjkZBc/H+M9mAM4FUpYAKer/oCtNc7yaPUV71BD/3DiaCzVlb0nMfMTMeuGbD+Hlca6P
         r4VSjQeLNyfzQJlIA6elCF9rQxym2gAh4YVU+W6RfeoJdWv6Me6EHceaqxLJImwtIR+E
         /eUtXGrohFHW/eCgtnN9GutEn8wLEqkqk0rWvbQKRt9eIpCcufoqllMdZvhV9YYn0Z0a
         SoGNv3Ao4Denslw6iLW0GTcg37Mz571H1N9LYW7KboPYMf40LvAK4mVKCJl9E3uiX+cT
         CpUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514902; x=1789119702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0CXHz7ekqSyyXlE66+G+z+OMwp8FaZS/VX/QUoLofYM=;
        b=PmspViID0GMQOdJDKTfyYUPJE0XNrme8xtwLB9MsVKDxjG1LwBq0qaDXZE8bjfnvI+
         VFvtjMJazIlxh7NjovGq8A6ZzbGlue0IPg79pUjZg5XFxNt+HBfyjSTU71rCjvwGyhlT
         BVZf7sNsfu2NAUqtRH8JujjkGDF+Q8mRhLyYoUl8T2AF3FW+xJpSkZ06g4Gy2Eq5kiUo
         gFJ7kNGNJ6JQF26jZQgja4a4C3NN/672m02eOgVXHQ5u5EzoDcZjxxUGmU7WnL5JRh+h
         4LVNqJVnIbVW621WbTBOJEyHWQQ51SS1kx8P1NUFuVSG1/p/e/po37g9HYgOqXvPLmQV
         6k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514902; x=1789119702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CXHz7ekqSyyXlE66+G+z+OMwp8FaZS/VX/QUoLofYM=;
        b=LXhwWWsNa9uUu8QwaDQNcnKkyes08XQMWOXBFakVro8W7RqCpWr5U9BLVTeNMc5qkp
         lrxElO9QSXnPpOWD4lsFzOJCEYYZszd3Ugzfbm1iXXVBAYHBeiBxecwwimpiXc7HuFLr
         Msusr7etF6jX6ADegdU2ANkOCtZ1ENYfbjYrs10/xkmSvqgce3fvZGnhyrRFLos0Pqx0
         SGHFPNVjCOUilgHP2hyBH+eL13RD/qH0alW5bt+RLicusva75g400MnAN7cBaEOV5tE6
         U4ILHyBLZHsc0lSMWG6uYEiiiaVcufWVTgAMtiK0+j7cjYfZK9GwxgZO+EvrIVNCgsqF
         F3Iw==
X-Forwarded-Encrypted: i=1; AKwUvBy3HSiCQa+TDVvGPdFi8Mx0OQa3VG2Bodxl3vTdt6GO8GrOcqqxDlAY20SL+i8uKPyFIiYqCIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kAW1/7cZZswI85/8fpmL4yPxQ56NZ5gAbtSzu+66W5woelKAwW
	M5xN4ao1SldXaGbykkgZRbQg8Ls2046tBLsRTFGu1IY/6lgysrYMnjEgtH3Ktx4bOqohgYBwTFC
	UW8+ATYV7ghSrgpF5RVCBNUVbOdTA8DpS6YP1tD+lnncyNXMzahDueDv9s3tL21s7G2rU3sghwa
	wP5LcoVaPPbUtVxCOGQrRsavdh7y9I9ieuUFpWtm/+ow==
X-Gm-Gg: AYBFou13qCxYxt/6WnlUMcW9c1ztDdtVP9PJ0clRqPPDABtH7JRQ8hyCbNCPoNTv9Wl
	eSC8lWFDTeSWkpsAhRarVPwnD0D7X2G9jDZF5JsZjmO2RwdUhEGjWhV2JBdnmbaHN/diK+f0mis
	vhOmSquI9NdUcCOtHx3DX0xeIvEOppX2oapgCHuMNsJ/c6krJ3co+PwfQPCg==
X-Received: by 2002:a05:6a20:c89c:b0:3d3:ae1f:d7f6 with SMTP id adf61e73a8af0-3da3a0c387cmr7804027637.22.1788514902434;
        Fri, 04 Sep 2026 02:41:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:c89c:b0:3d3:ae1f:d7f6 with SMTP id
 adf61e73a8af0-3da3a0c387cmr7803981637.22.1788514901957; Fri, 04 Sep 2026
 02:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806130233.465653-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260806130233.465653-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:30 +0200
X-Gm-Features: AcwNN1UVLDail-yVP9JPMBYQDYksgVBfNqLh0P4igKJMMIGBKTJgWq3Cf-eBdc4
Message-ID: <CAPx+jO9=GhjvLonVfiy8tUOTAPeKv3aiFvLMJiDMQOZWb4+W1Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Cancel SDIO IRQ work before freeing host
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=F+xnsKhN c=1 sm=1 tr=0 ts=6a9a9257 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=MT0tJ2P3ZsTGS_FN_9MA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 9C_IXOejUu0fhmLrdc_xJRK8v-fiyGVq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX3TiDLK3CSKUy
 yrhpXqJ7SGIkHv/RvTBrVCTM3JzsAVc8dtRt7fQJ0U0pkAMmYKgUoydMhmt3tgY8I0kX6xrM3JK
 0vGtnMY1qNynAYJVkc6S6/qvVglvQcY=
X-Proofpoint-GUID: 9C_IXOejUu0fhmLrdc_xJRK8v-fiyGVq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX7WVCDXD5AREh
 phgg3KINYI6Rt/PwAnFjHBwGkgT/g9dK1p8EHvsMYutflbYqLSweDzqbUl7lNLLFgiiEjfRVWMY
 J3B9NhjfMqZZYg5uMUu9dYqEfiAKVvx2Pds/8WUvQtgfOv1qInPs70lUZuTwarpcYawnRZX5uf1
 zCjEHtNXxfZYLIaO0nd/+nVRDA/9ieQksdgPzF5qPLF5mwooEH4x3sP/g3irC0gyqSHp6FjHkwY
 ww1HsOBxyF0zRznFQoDwMPgJcH6awpWZ7IbUgfCXwYfI4WeB78lVbR0N9A9nh4jxxOysk3S3HIz
 oPE2jjrv4AOjwuDkRqo5Ybv6QX9q7cnoiXmDvOxwdlNGg7i0GVQCjcINi5/TwdSUKqZybxA+0sA
 eeFRXFOqYTao1KD6XoHKtF3eTKNjuc2z+e5HtMz6ahiYcNCmZtNZRx7CSbtx0DDAUmaSbBy6j9F
 dSosKdMWmYktXib5CUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040088

On Thu, Aug 6, 2026 at 3:02=E2=80=AFPM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> A host controller that uses sdio_signal_irq() schedules host->sdio_irq_wo=
rk
> from its interrupt handler.  That work is only cancelled on the suspend
> path (mmc_sdio_suspend()), not on the remove/free path, so a worker armed
> just before the controller freed its IRQ can run after
> mmc_host_classdev_release() has freed the host and dereference it through
> container_of().
>
> Cancel host->sdio_irq_work in mmc_free_host(), like the existing
> host->detect drain added by commit 1036f69e2513 ("mmc: core: Cancel
> delayed work before releasing host").
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: 682696605c7093d ("mmc: sdio: Add API to manage SDIO IRQs from a wo=
rkqueue")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 88c95dbfd9cf..becb5a850a2f 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -693,6 +693,7 @@ EXPORT_SYMBOL(mmc_remove_host);
>  void mmc_free_host(struct mmc_host *host)
>  {
>         cancel_delayed_work_sync(&host->detect);
> +       cancel_work_sync(&host->sdio_irq_work);
>         mmc_pwrseq_free(host);
>         put_device(&host->class_dev);
>  }
> --
> 2.34.1
