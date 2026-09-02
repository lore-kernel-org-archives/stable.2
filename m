Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3134F27B
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314481; cv=pass; b=d3w23fjzT5s6OPgVcWxglNpYD9EaiNBuAgTb2BpVQ8EYJFImsbxFPx2pb2utvLpq+4gAQF1kZsWfLZqnwnBbXaJQ4SVbmxramjEG3R+7xBE6M8gpfZYqxiT+tpts5trsjTt6KvuOqVQNu1yrGu8sSWz562aIYpVxW6+6xJSnGXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314481; c=relaxed/simple;
	bh=U3aa/uX2QJ6x8/cys5PY/EmIY6wqHCxmh0up08kwOCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjfQjzU8VlscGfx0Av7NxIRNWngBVIr2Min+gtnoxGVlbSO2gqxnuiw+5uhNITLOyxXaXXkhvJhHwESDetJ6WFL504jSZamzkoQncyqXzBOli5pjbaO0T+1nRZH4sBKAc9aDwM2sb4UY79kW71TfTKRqoZAVniK1HfpAZPOTiSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIGjMTBm; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIGjMTBm"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52faa58bff5so140931cf.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 19:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788314473; cv=none;
        d=google.com; s=arc-20260327;
        b=fjhHSA85zXiAdfhDoQXsojKCYjWavoO+Z3c82qC398Oz/zrV7LJwf40w2Hi/GhO735
         3wMtZ7bV7e09L2tFVj7BwH15CAXiEfLxZE1O+W0p+TuiaaVQ2Ltlja4gjuNXNYUuqnn7
         PHf3HLSXNmhHgZ/+sJdymy12cpVA3o7cdcsux/3Y8P74dgZ76jVcpjnFykNJD68HLYwc
         S96izggeFjS+2fnDUUmGvaWBSWmJh0lTPajy3mOvSmB8x2fYd4xiYoaMSMSlpyZ19aWP
         thlK38cH22IHU4ctd8II4OAqbfZz/v0AgpoF3wu8c4owEATTs+vzi7PscoWCcAsuB0Oh
         9RTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mCiyEAo5wxMzkcXu7vU1R6+a/fDtwqnpSwvfpXQcP5o=;
        fh=sy6S39fUjksj0JaOnX4dhQSg0O1L70nB8U0BCGtVTng=;
        b=EbUcj73XRtDmzgZIbutojfiRY/TWm6Nb2Xj0mVdADF9o8zbsNEqQs9ASHOhfXHVYWg
         beEQAdBV6+CipJwEV6h8nkOc1Stt9omK6qZI2RRw2xOGhZ3rndH3IMJBJsajNgkxcEnV
         D0NCnMJedVuM8F2jAebBUNGwRaNZgWqQ0ABDhy7RTBIapB4Bojv2Sf8DR0g0iAwFbxoS
         E4Kgbf6xXHK5uG1Pl2H05wzn+51yR7uvkRuPJs/PVgvQHNC+lZoNMZuQaEU7ZtFOaRID
         wV9v+n+ks4FyVXXGlWcLUYrtfC2bSHqa8wCpFUn3l1zjdsnnSpyX+cRciAm4q8/Ovqk8
         2q6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788314473; x=1788919273; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mCiyEAo5wxMzkcXu7vU1R6+a/fDtwqnpSwvfpXQcP5o=;
        b=hIGjMTBmM3Oj1b0BTXO2ogWByJcQEr0YgZ5EDJQnklj7mkITqmbuTDB3pRAZEOBeLx
         sdFqQN94oERcWYCMTCs7whPrflUW4dA/5RpE8233FovbO4exrjwGe/3UamUcjarYFTH5
         /U5b17OMQzyHsq+UtGXjOoCDOqYaAuXwr/0V5HB37ekIx6QWt0UVQFAmqpZ5JzSX+TbQ
         ExHy/wEx5+pyjk/9qAoPUIJ6qgbrkK9iiNYn2eGHkWbf73ywm5cee9VJ8OwRI04JbQ3o
         zszOFwDfqAl4NmwO4XfNBT/N/yZLHljK09J6JFrDA57QLWoiylrIHmwHxiue7QbyBSTO
         X/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314473; x=1788919273;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mCiyEAo5wxMzkcXu7vU1R6+a/fDtwqnpSwvfpXQcP5o=;
        b=rlLG22KRJmpTDdM66cDIZbmRWF6F/r1VUKIuIAOMvQR6tILWP+tOxNnGd35URWkV90
         gDG6SiGyL0O9nCC7Bu3NmZdIPLYDBv5zj/XpSNni9SnKhZ3N7ikYGYIiQfRBx4MXnqL0
         pKPr7vOgn4to2t38Z30cwnF3I+v8Bj3mNVZcHqAh0ybCAApMgp2XXCQsr1ztESCRWUc0
         jZMrVuZHpTP3sUWBrHY0AROI6+kWNs2LXFMddIHhIMEkD3l/jIUxgiKLBAQ/E1I3J4hR
         B1x7Z3+GB0Vaq8KO2OyZh/WAYvr4LlaeAm1erpP8GG/aly66Gh5zNqq3KJsFMlLXdUNF
         PTNw==
X-Forwarded-Encrypted: i=1; AHgh+RoRoiplg87LMUjhSjxXWN7eT/5mKKIuBKtiuL8ZgIHIQVxUkiMgEr1ldLio11hWc2EimWs1QAQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l2t2qOTbsK/IGXUJJ2D3sE+0ljhMQPB3j08KAz+IZDnWouCbgi
	U1P5oxhOncK09/RW79QU5W8UTw48h3aR2Fdh2jMxVxALm67k+G+IEubdqaYWir+JdGDeN5Sznfx
	qTLtaG6GB7IQVb2awid64o8MSaVkJzHYXR+XZhlow
X-Gm-Gg: AR+sD11i2n3hta/YKFGOC/KhN7e1gtPdCp+JnczmxbbCNnr79vDE6+Q7gYKHJ0jaI/N
	eiBnhJ/0DKKnd8mru/IDEQU+2WZtoT/ZmR/wjaKDjzaWBuLgV4EtiszMMpINBdeA6WeIuwamaNU
	13wfduyuiqITLfmVZr5EG0cl7v4NVVAusgsdHJ/AlSdWa6iU6GdJ2JTB0kukJEytPIqtT+9ffYY
	WrnYFxaRs5QNgKbPac4C1Ana3jYdDI1+vsb3owo8UuEESIdcDED6uwV0EiEAnUFCfPH5fsj1QyW
	6xEuUWJEITwN2EZf5FS076OlN5bsShFpHDsVoW++E5Wg6wJ1nvaUXmtdLAEWuJfCaO1Jn8A06r8
	U
X-Received: by 2002:a05:622a:1b1c:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-53035b0244fmr4577611cf.7.1788314472279; Tue, 01 Sep 2026
 19:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE14pdef2u=Eo7M9NGdABzsjy2o2SO=Z-U_BbRn9n45nJJR+wg@mail.gmail.com>
 <6f78c4bd-a70b-402d-abfd-599091b67674@acm.org>
In-Reply-To: <6f78c4bd-a70b-402d-abfd-599091b67674@acm.org>
From: Stanley Jhu <stanleyjhu@google.com>
Date: Wed, 2 Sep 2026 10:00:33 +0800
X-Gm-Features: AcwNN1UiOHbd-lkyUlqZ5G0VRdeSeGP_sY6ZABq_Mgd0A-kN0QJuBUaEk2kVvBk
Message-ID: <CAE14pdcnmcvPZv4_pKOnH57OZmJBqe8DTwRnmrMTwOnBm+iOOg@mail.gmail.com>
Subject: Re: [PATCH] scsi: core: Set BLK_FEAT_SKIP_TAGSET_QUIESCE on pseudo
 SCSI devices
To: Bart Van Assche <bvanassche@acm.org>, Stanley Jhu <stanleyjhu@google.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <mkp@kernel.org>
Cc: hare@suse.de, john.g.garry@oracle.com, hch@lst.de, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sep 2026, Bart Van Assche wrote:
> Does setting BLK_FEAT_SKIP_TAGSET_QUIESCE on pseudo_sdev break frequency
> scaling? ufshcd_pause_command_processing() also calls blk_mq_quiesce_tagset().
>
> Why not replace blk_mq_quiesce_tagset() in ufshcd_err_handling_prepare()
> with blk_mq_wait_quiesce_done() and drop blk_mq_unquiesce_tagset() in
> ufshcd_err_handling_unprepare()?

Hi Bart,

Looking at the three call sites of blk_mq_quiesce_tagset() in ufshcd.c, they
have distinct requirements regarding pseudo_sdev:

1. Clock scaling (ufshcd_clock_scaling_prepare):
   Requires freezing all queues (including pseudo_sdev) while clock
   frequencies change.
2. Command pause (ufshcd_pause_command_processing):
   Requires freezing all queues while TX equalization retraining runs.
3. Error handling (ufshcd_err_handling_prepare):
   Requires quiescing attached logical units to avoid HOST_BUSY retry
   storms during host reset, but must keep pseudo_sdev open so internal
   recovery commands (e.g. NOP OUT in ufshcd_verify_dev_init) can proceed.

Setting BLK_FEAT_SKIP_TAGSET_QUIESCE on pseudo_sdev in SCSI core breaks (1)
and (2). Conversely, replacing blk_mq_quiesce_tagset() with
blk_mq_wait_quiesce_done() in (3) leaves logical units unquiesced, causing
incoming I/O to storm the recovering controller with HOST_BUSY retries.

Would it be cleaner to keep blk_mq_quiesce_tagset() for (1) and (2), and
handle (3) locally in UFS error handling by quiescing only logical units?

    static void ufshcd_quiesce_all_sdevs(struct ufs_hba *hba)
    {
        struct scsi_device *sdev;

        shost_for_each_device(sdev, hba->host)
            blk_mq_quiesce_queue_nowait(sdev->request_queue);
        blk_mq_wait_quiesce_done(&hba->host->tag_set);
    }

    static void ufshcd_unquiesce_all_sdevs(struct ufs_hba *hba)
    {
        struct scsi_device *sdev;

        shost_for_each_device(sdev, hba->host)
            blk_mq_unquiesce_queue(sdev->request_queue);
    }

Because shost_for_each_device() explicitly skips pseudo SCSI devices
(via scsi_device_is_pseudo_dev() in __scsi_iterate_devices()), logical units
are quiesced while pseudo_sdev remains unquiesced for recovery commands.

What do you think about this approach? If this looks reasonable to you,
I will withdraw the SCSI core patch and submit the UFS-local fix.

Thanks,
Stanley Jhu
