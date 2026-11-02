Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657393;
	b=iWpBzySxb8KwIYA4FyOq7dn1UKB5a2n+one2ac23YMWDv9YHBoC6xdOfk5TdnD+UfX3f
	 PAj8XXdcr+xlxofRKYTh1ubTG5xAg+f7Bm2gYk6NCkUZVexGb8UM2rMQpaY9LPywfVyou
	 zYOUpDZNSZFFs1u+jN4zO1o+iXUgJjSPtYal16qNTI3Q2+hdU5ZZjyUeVlZNFK1MCKOke
	 WYI7PxurTpnrXQ87Nq0kfY6tb0p+95c4EBxtNjtaREIGJsbLN6p/exfNfSk3ZJhD96CHf
	 qHdRWxKa55HxAPW/rbcCFaTkypoRgwZ3o/rekKZmE2FLE/iZ6lAJFGgzN3QYzdMaMbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657393;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
	b=kXqxOABmJbO55nEwq/dD3ryUYrCqirjQ4i1ff2C/CKVhGXNpEwQiVGJhf/yKc2xIsMwW
	 MN3JnCT1GFHGOpbVSVutq9b8Y0n/Y5aQAhjfD0ULdDPpI8rTzLKpvLBOmhRlXwTzb5aRP
	 fKCNH+SFxxd85dmYki0zw7gSsvkmhqSpInKd9xKbxN0WMpWvWxoW8fTd2WVXPo/hTHSVC
	 vL/OkcZ4RGVjqfmV01kuFlJ+1c4tgPvkmdhgBkLh/cqfBk/vPiZIDX57msiO8EAzcB9L6
	 hxo1bGf28UD8w9mHt2yq8skesbL6XUHN26rtad8tDmbxk0p9rQBgEeqzhifw6YDhbwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Zi9t3Ta/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sUSZFVg5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C11606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C11606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zi9t3Ta/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sUSZFVg5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793657390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
	b=Zi9t3Ta/286WYIuLbICG4S12UU1PeptyJp4kgXuA/K/8tkb8Qcvq7HFxF+dDQEoBkKY+cP
	W2nlhuX5Uv6knB3ng9T/z/jQ3V6C5HKFCfgZnow9CO/yKBh7GjvPX09CjamIgDC7baZk9f
	kP7PWJOS1C/tVLJ/vz53+ILU4GGmhC0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-dJJYKEl4MpOHnPTPk3V-lw-1; Mon, 02 Nov 2026 17:09:49 -0500
X-MC-Unique: dJJYKEl4MpOHnPTPk3V-lw-1
X-Mimecast-MFC-AGG-ID: dJJYKEl4MpOHnPTPk3V-lw_1793657388
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48b02d63407so2799744f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793657388; x=1794262188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
        b=sUSZFVg5XUl3+rzviIOSe7vTCts9mrw2efAzO2c1SB6fCaIPsBYTUxrAbJMwNLXhoD
         7IVDn/jAQtzEESqMgQgr7EGcvbipwUN08vNkHdvWutKHp1Tye9o7hE/DKvhmUb3I9c3S
         cuw7//8lX77Fx0sL2hFWa1SgmsJ1JZ42uu5Tcxz3ye6fLN/SoF197Se2JIrx5yxbMfNM
         9gNL3dfWma5mLoBgGfBMDukK1uqs4cbdcasvtp1TPaxTXwn9cR5B/XyShzAyiwStt3Yv
         4m8whjhW8uYXKNp96oZ/LsUYEJ/Pd2fJH+JXlJ+tcd6pPhB+HW3ONxnYNtIuPpAqvVrP
         8Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657388; x=1794262188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
        b=grnulk658AAzZWQrJl+a63DTmpugEBF/HzhszAO5uCMZyYdh76tySULZ4FAPtpf2AP
         CWeyO9j4+NwjLlelWOPeTFDomJSofyEhfMiVWdVhOrZZOoLSz5G4HCo/ukJ0AUpbafhy
         BPlaHfXtomUGg7DD/2mJF99PsOB8DLp1odFCqc7EMevb7vuvkLNkYjSD0aE9yYsxvLKC
         F8ZkwiHvO95npFsqVm8Py2F8n+Ac/SQI8mbeor+64KNJqfKJlwK4vJ1RkBf5Ij05+rDZ
         KT4iFDJBx/Dw9UEsdnaE28QMuwaHBQbW6hneuekKHHWLvRsKJMSD4eyJrKznb1t/gU6M
         oxzA==
X-Forwarded-Encrypted: i=1; AKwUvBxkwAwBl4EFeTaode20CTTi2rNSLnBbBkD9fWqO7SSNPN0ZldVpNiFakcX1ro0+u5KcEMCnbNk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7kDRsdxDO12pCt3BZLJZRUYa8ke+tAD3gdBZtMgzu2QUkRTM9
	hnypc+BEUmRdmWyIj4Pk+clA9Ge4l7Fhl+kK9B9lOBqzhm6kg20K03sxi8Wru2ufY8hnYxVAL6a
	yo90IbYWapkpGWiwVtXjoc99peCuf2vus7VGBcdAh6tIs9mjyxKFqWCV6uA==
X-Gm-Gg: AYBFou37hnWXGZmGdGJgpQaZhZANfolDISMGrYgndwqtL//+nuwGLWbqZWwtjSgeqEH
	9CStIrluOZv+8JAMBNOieTyHY09T6uCm4jGUH49fhG6yC8qdHAWNTUt8X4J8lc4nPYnV5pFLxxy
	vVW7Kx4zVTlRQVF7pyWYGpuQpLRU87xZsbzs8dOLma7CPB9kfSnBJAyVCM0mf1FG5Mvx+2TrUWz
	P9HyZwtmZ1EDzC0Lpt2Irq/Ik/TDJQ8l+FhJ6PjSbz5/1LymjjgBrOmuOinJRWCaYjP4NhuN2du
	KkiZ+WZHA2/Zps65X3K6PUYdjd2QF0NsOTMACYxQLot7U7dvfgHo2Im0vAHc+Ix5LJR0VbYgpL5
	1pzYES1hAmNU5npTuRnjB7LD/iss0CXO3pRJ+8PDRzQ==
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr265865945e9.3.1793657388279;
        Mon, 02 Nov 2026 14:09:48 -0800 (PST)
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr265865565e9.3.1793657387857;
        Mon, 02 Nov 2026 14:09:47 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm20624049f8f.15.2026.11.02.14.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:09:46 -0800 (PST)
Date: Mon, 2 Nov 2026 17:09:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop
Message-ID: <20261102170928-mutt-send-email-mst@kernel.org>
References: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sat, Oct 31, 2026 at 01:33:13AM +0000, Aamir Ahmed wrote:
> Since commit e1fad12dcb66 ("sched/fair: Switch to task based throttle
> model"), a throttled task is only dequeued when TWA_RESUME task_work
> runs on its way back to user mode.
> 
> vhost workers never return to user mode, and vhost_task_fn() only runs
> task_work via get_signal() when a signal is pending. A busy vhost worker
> therefore ignores its cgroup's cpu.max, while its runtime is still
> charged to the group, throttling the group's other tasks (typically the
> VM's vCPUs) harder.
> 
> Run pending notify-resume work at the top of the worker loop, as io-wq
> does in io_run_task_work(). Commit 12013e3d4695 ("KVM: powerpc: Use
> generic xfer to guest work function") fixed the same problem for KVM.
> 
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Cc: stable@vger.kernel.org # 6.18+
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Could you pls respond to Sashiko's review?

> ---
> Tested on x86_64 with a vhost_task-based reproducer: in a 0.2-CPU cgroup
> a busy worker drops from 100% to 19% of a CPU. Reproducer available on
> request.
> 
>  kernel/vhost_task.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 3717885a599..7fa96e1b85b 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -6,6 +6,7 @@
>  #include <linux/completion.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/vhost_task.h>
> +#include <linux/resume_user_mode.h>
>  #include <linux/sched/signal.h>
>  
>  enum vhost_task_flags {
> @@ -31,6 +32,14 @@ static int vhost_task_fn(void *data)
>  	for (;;) {
>  		bool did_work;
>  
> +		/*
> +		 * We never return to user mode, so TWA_RESUME task_work (e.g. CFS
> +		 * bandwidth throttling) would otherwise never run. Run it here,
> +		 * where no locks are held, like io-wq workers do.
> +		 */
> +		if (test_thread_flag(TIF_NOTIFY_RESUME))
> +			resume_user_mode_work(NULL);
> +
>  		if (signal_pending(current)) {
>  			struct ksignal ksig;
>  
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> -- 
> 2.43.0

