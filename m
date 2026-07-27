Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D732F770
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162538; cv=none; b=LXSCx/DWoj4uP2UGvd1nlksCqW4egL+BW0S/F72Tq34rY7fy92QPMxS0QEwhqrC0scIDgadIWl0PpdT6VUQgIfHEmsOgxDmNE0jO4v0uLY3qOQVxs75CIQu9Ds+ifQ1Fyu0FgLa8gTt0cpnTpEKvk/up3lUw2wJFfgDnd2tIsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162538; c=relaxed/simple;
	bh=1F2E0F8oWdzcK8owdnuCkCeBAUkTA6kxmehpUYOfQYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e46I7V1GDpeFM3rlXzfKyqhq1cmMMO/CwsRU62O/ZcdXrltLS2aHG+WdeXmc27xWeRLJoNOiUsAIVquA5WOR55jYWj4Kn9w0uc153KixH5R3nJyfI3nEjrjPI3Blb8A8S2m4cjbAJGzLA4JbEiYMPUN6PkQqwvwmFUtZj8Mqv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTQR4u7z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcVPLYe5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTQR4u7z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcVPLYe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785162533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgFmd6qXGD/1u/B/qklK0gxra4znkvRNbgLq4PG6yjo=;
	b=YTQR4u7zc0Q9kmugq1mbA2LxjrGmGAF8ok3stZKrLx0WvCONFA/jW15MwNM1j8upsvIX5U
	37KSfd9CJcWihWlOzh/NF93MycytW2PBTW1oy2ob2mkZMNuYx/GAR9q87Nq0fC9I5/6MIx
	AiAwTFUBduD2xxNm2t9s8vfq/LBIMwk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-UT6Yg-j-O02SFt7pRMqyCg-1; Mon, 27 Jul 2026 10:28:51 -0400
X-MC-Unique: UT6Yg-j-O02SFt7pRMqyCg-1
X-Mimecast-MFC-AGG-ID: UT6Yg-j-O02SFt7pRMqyCg_1785162530
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69c20d12deaso3563570a12.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785162530; x=1785767330; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgFmd6qXGD/1u/B/qklK0gxra4znkvRNbgLq4PG6yjo=;
        b=LcVPLYe5T4gZ+qM03YZPW3uwZu4kay6mOYFhf9mDuUSAwieHUI1vfD6xs97UtxVexB
         Phtmrt7nltPi14CWKepGdX5YDZPdUWGgMxZleTR1j8hOjnLBf4KTeCG4uhTuFwccSvJj
         EM0GSIoFG5dyOmMPLaw+Zx7tU+rfHrJnLUgZ9spG43uKCq2mA1zjIU+JlNaSBc4nybdT
         6yRY2MS4XrzqJ/3IXPQTGd5Jn4RqWjQ4FH2p32lmXNd2Tj6KhEerK41dTTb7Z1k56SUx
         nAjpypPTejebcaFnyqitJbNi8rLx65WOMoa401bcUZLmdc8tosIcEcMe9lDYA7gyQz3i
         kciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162530; x=1785767330;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgFmd6qXGD/1u/B/qklK0gxra4znkvRNbgLq4PG6yjo=;
        b=T5d1Ggft6oZMepP2nEl2EvPC+mfHHLsLXlCzOe4Q/8e8kr7e7IUQcESYpwVgRXrd7D
         me2fFodVtDCkNbdetXq5Ofuo9wzYl7num9zJcdnqggon/sYufXBQ76xvZs6Bax+8p7s/
         4KbrtHcFlSM+g4kVBKieQ8V12EaIIWXo2v1YPDdgW6ZiIGu2kTy8WJrjVCfLtlff8Oaa
         LmEqibYJ2CgS8zJRGkAtMQvAZ6h8jTJLPoqOpkQvwAdMXJ/UKCyTK15MxZsPdBqePuNv
         aTtduhoUjckNG1+shd3G/apr22EOnOJzdblNYJKCtVWWYbSwnvPXjSWTjhS85J+S1nQT
         If0g==
X-Forwarded-Encrypted: i=1; AHgh+Rpa4sp6K6xv1qmJgJ2ZTgTLn2czRAbqHV0tnmYcpGXxpKvGHWfOmcez1luB6jwjpQfrlaRIzwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBB4/IIwIaivyiteGeVeNl4ChRsyaUClW2VyaLOpfGKotSUw/A
	L7bFXUr9aSqxPxqZzEMdhT0kwoXXo3bDy7cb67Tt3Iak70l/HBIyaGXOz71AVN/1DMSr8rn3RRJ
	BdaN1a+KFaTwq393+lynuk/ikXmPYcqxZSChaiHkM93r4ZJxbnPck7Kel8g==
X-Gm-Gg: AR+sD11cQp6SL4ombzMbir6drOKcMxYj1ZBSX5sf6UxqOmeQPkHq4PQQ+S5czE98f1k
	LH4hcCvFRWmzszCBz2cSQ4alpNBBwmgH9BOhzlkplvKi+o9D76uHUicvzOrM3fqNJBikzgEStWk
	MrrQYmWhB+h8MuShS9iER15s3Mt5Q+tB9s4kxfCDRjriTNjUaYcubwF3QmrRoT22vAZ3/CxQXZ9
	fQGNtoz3cLDwM8zPjwQXzLDeIsHM07ZDOO6/F4WysJiPR+08QL8yX/E4ywf19g9oJMz91zRTAVP
	GlmqCrFsiOT1hORlXWdlHfUdFZ3EWvuH9zjdMx4s7XyzcCUi4sfrnmOkrq7jvZhVBPYbH1kIQUC
	bPHUjVZ0IDYufrT2mHeMnNgadwzpa4jDaohpLWtYec0659Erbsw==
X-Received: by 2002:a05:6402:358b:b0:698:9450:92b0 with SMTP id 4fb4d7f45d1cf-69fc1007196mr3646736a12.1.1785162530102;
        Mon, 27 Jul 2026 07:28:50 -0700 (PDT)
X-Received: by 2002:a05:6402:358b:b0:698:9450:92b0 with SMTP id 4fb4d7f45d1cf-69fc1007196mr3646728a12.1.1785162529675;
        Mon, 27 Jul 2026 07:28:49 -0700 (PDT)
Received: from [10.44.33.167] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb50bd183sm2838839a12.4.2026.07.27.07.28.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:28:48 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tonghao Zhang <xiangxia.m.yue@gmail.com>,
 Aaron Conole <aconole@redhat.com>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: fix potential UAF on meter attach
 failure
Date: Mon, 27 Jul 2026 16:28:46 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <5EB5E9EA-2E4F-4226-993A-142C79A6DF00@redhat.com>
In-Reply-To: <20260727121022.198461-1-i.maximets@ovn.org>
References: <20260727121022.198461-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 27 Jul 2026, at 14:10, Ilya Maximets wrote:

> While attaching a newly created meter attach_meter() function makes
> the new meter visible to other CPUs but can still fail afterwards.
> On failure, it detaches the meter back and returns an error.
>
> However, this is an unexpected behavior for the ovs_meter_cmd_set()
> that uses a plain kfree(meter) on attach failure without waiting for
> RCU readers to stop using it, assuming it was never visible.
>
> This is never a problem for ovs-vswitchd as it always creates meters
> before creating any flows that use them.  But the UAF can be triggered
> with a custom application using uAPI:
>
>  BUG: KASAN: slab-use-after-free in ovs_meter_execute (net/openvswitch/meter.c:653)
>  Read of size 8 at addr ffff88810d152650 by task meter/2508
>
>  Call Trace:
>   ovs_meter_execute (net/openvswitch/meter.c:653)
>   do_execute_actions (net/openvswitch/actions.c:1407)
>   ovs_execute_actions (net/openvswitch/actions.c:1584)
>   ovs_packet_cmd_execute (net/openvswitch/datapath.c:703)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
>
>  Allocated by task 2519:
>   __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
>   ovs_meter_cmd_set (net/openvswitch/meter.c:422)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
>
>  Freed by task 2519:
>   kfree (mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
>   ovs_meter_cmd_set (net/openvswitch/meter.c:479)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
>
> Fix that by making sure attach_meter() doesn't make the meter visible
> until all the checks are done and the function can't fail anymore.
>
> This also makes sure the "hash" value is calculated after the potential
> re-sizing of the table.
>
> Reported by Trend Micro's Zero Day Initiative as ZDI-CAN-31642.
>
> Fixes: c7c4c44c9a95 ("net: openvswitch: expand the meters supported number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Thanks, Ilya, for looking into this. The patch looks good to me.

Reviewed-by:  Eelco Chaudron <echaudro@redhat.com>

