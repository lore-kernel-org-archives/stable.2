Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427385;
	b=xobxSfDVBO9NHrdtGp4WbJoRoQDRJsCgBBWiDZf481TZzyHSqhtAfJzR+3r/jwg88u97
	 kuvyQQJRugBq4cHlewnAoDexXENp7iqxgsheBZB+669WGvR/bHpF8EuvVzsu5wc5ka3wR
	 Ta1nlhI8my/msqaM1nEgGZwydQag1Dq+qBvdHx77gvys8MvUVHwg0QcyfxaKsuUJ1tSAZ
	 BDnjjpflOA/+bn0g7KVkGdRxh+A4pb2WtNf+8SPFDVl2hriCm3lb349dfZ0UGlmXWOIyy
	 MYFs6VMP0XQfQ4ARP3e1u/8cw9G6+/i+dQpDdutqDu65sWiPYfoE4WGPWHuCAMg2Gkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427385;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=e6r/HJ4fnxt+Ympvhnm3lqzuKNTZyC1RsNKqAM3ic5c=;
	b=UeE4gUho4/ckvRROYRzlUUMy28Nw3OttjdlMOenmB0KuEHTgj6Jzt0B0p3JjWL3Y68pu
	 3YqnUiMAVaniIXzfu3aEoqPrpxVnbfvpqd8upQTV9G0egTaWRAdlfmjpDRxdfD5qvUl10
	 IFAmK9fTOXpnnpPjrTKcwbKTi9lg/W5rg8knPRzzkWjVTbFcNmXJWcmCdtOFBJEWdnN3q
	 ygSJ+B4C58L3cd+0PBwUtyt3HMRbyiyAR/sntkrftCDxfrEygf0TPCiYpj2GPtTwTLeXU
	 nZHif26scV+DfjPKvWbNWJ4cvyeSOjUmRcPTLUAgbCA0kvirTFsm3NQQlMrmudbrnJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IUo62jLr;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB3606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03BB3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IUo62jLr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794427384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e6r/HJ4fnxt+Ympvhnm3lqzuKNTZyC1RsNKqAM3ic5c=;
	b=IUo62jLrmILog1INwiJh5Q7pNyYiP+5izpEBjq16P9h3eiKLTTl/moRXJSCgGWsokSABOx
	AKkz9L5+HyRcCg/6m3qjwNWI3ogriIPrt83pv6shQgaaUxT4SCj2I4rWY4Hkcby80wtt/m
	lznDHAIFMuHN5q77DJ8uuWXyNIoq+Rk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-AM8UFLq6MNq3UAZpDWmj8w-1; Wed,
 11 Nov 2026 15:02:57 -0500
X-MC-Unique: AM8UFLq6MNq3UAZpDWmj8w-1
X-Mimecast-MFC-AGG-ID: AM8UFLq6MNq3UAZpDWmj8w_1794427375
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F6E219C960E;
	Wed, 11 Nov 2026 20:02:44 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C57E3344;
	Wed, 11 Nov 2026 20:02:39 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 11 Nov 2026 21:02:43 +0100 (CET)
Date: Wed, 11 Nov 2026 21:02:38 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-team@meta.com,
	syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] reboot: halt when power off fails
Message-ID: <avTJ3o-n0UZS0YUj@redhat.com>
References: <20261110-reboot-make-task-dead-v1-1-af88a3f37bf7@debian.org>
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
In-Reply-To: <20261110-reboot-make-task-dead-v1-1-af88a3f37bf7@debian.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/10, Breno Leitao wrote:
>
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -791,6 +791,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>
>  	case LINUX_REBOOT_CMD_POWER_OFF:
>  		kernel_power_off();
> +		pr_emerg("Power off failed: System halted instead\n");
> +		/* kernel_power_off() already ran the shutdown, only halt. */
> +		machine_halt();

Agreed. Even if I don't think my ack has any value in this area:

Acked-by: Oleg Nesterov <oleg@redhat.com>

