Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C823E40E0
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747735; cv=none; b=gFXSd8pd5Pwyw+IxkaWK6Mkxkqs/BUD+Rm2Lpqhym0JvvKMzrmiPrcmhuSmG51VTZzxJXMiTRmZXVdLG7rRGUx1mCzIueTeWjWrc5hHfgyCoAsRUtS3hoteklJpPeSHBDdKQu+plDbk32nKS/+/WGQ/HSFPSc/jEjHCwIXShi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747735; c=relaxed/simple;
	bh=4AMJ4/YUrPp8c+UnnNwqZYiFxBTm23GrzrPTxaOoYuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjfApUC8HENvHcieANMjAOtBUoCUYmqG/HeCwwoyRRsf9toJr7w9r275QHFJY6Up090PT6JrqxQHFNOgNMrVhVhtkjSngpa9VBzIQD/63tO4v/NATaXnrwXEGN9HOzq0bauZVEHo6TJ7Or3eSWVweL5vNb+BRZNNrczHVfWve30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XazWImHb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XazWImHb"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso12237945e9.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791747732; x=1792352532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z1QFtV7KI5OFWzwbAboD0j9bhs+VlQKq149o9ZSjG8g=;
        b=XazWImHbNz702kBVNRWtoiti7WE0n0wXrlG1mEZBm9Ke+hFrxjg7TxPr8S3lAZ6jt1
         RBt9QDtIVI5xEtRFirEzLGViDX6SIvEiJlZFxQoa2m+Bfr+pX6sXixqRdc3/+DNZgkjo
         WvF+w9ybTCHojz3iB6xKt6+LSuA4xv2mslFfJ8MEZgnvXoOwPC7DMag1JP0ot0OF1eOT
         NEN1A8QnaMYX4UlUqWGiNo2pm3QgPDR4+2uBug4qzqFwt+NNjAyk7I5BT8sEobZbI7Gd
         ZomsW7zkwc7KZFLbA714kg1Fut4AbH3icjiu7sIHJVJhwWBQFVDJe46S1oQe3b12T7+d
         1Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791747732; x=1792352532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1QFtV7KI5OFWzwbAboD0j9bhs+VlQKq149o9ZSjG8g=;
        b=WcJzA99eg307mXWwIoBK+UL66VB2BDHGtPVxGddULy9XdtWdDuTqHjeqEh0/QZ4aA9
         t3Y5fJRXQc2pQaZW6s9laSxQLPJn/PQjQ2CKb+JMvRair6WmV4d3UNWUfzHyiUdU6bSl
         H5Epj8E9seVNKlS7XaK1z0Ff99Od//ZjtCN7Cov4WMshAyF6C4w4JtJRZTyzoUCVNmnV
         AWaIoxi2bewnv+vBJNLJBsVXK5X5pT/hjLA606syDdFT1RrW7IeOotb1OwqvEyo5f5eW
         4lJ8eOhdmsDLbALJBSKjvgKVVSBx+KT0BoOlyJ9pJVnoGgy5VtX1L2xDqjuwCAEPc/PW
         Y+9Q==
X-Forwarded-Encrypted: i=1; AKwUvByaTLvDWLRlwV32F0SeEVHJ0ZLqNjD99uFmTpFesGk5Lcm20bVLm8rAlao9RjS++6aQcQvL3LI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQgDAYjZH5IPTqwxT/lPyF90hfUVklIlLEhJnmoN73nadVOGdB
	Q7dO8JdX7wOTm+oWJFpSz+44EcAaKJWDOrtZ2CfpBf/29Btz37qtm1Vubpi8sbsz
X-Gm-Gg: AYBFou192yb2bsUhyc4r9/BhopYVwr35c70/NDcZyUWx6gc/ycMdeYIlxOWDbvChLYW
	wCTQ0M8TCZDCXjxfiALVbeZwy+T9K/xaMJtMV1dwLp6+ONhQyBbJzwe3kK2oN0sGoYSqXCnO6cL
	IXIeBqprN9UcHkaeKtldw97nbt4wi6Bhf4136rZ5EkKv3HSBs0esu0Nn027bRNTnwbA8GW/x8Bn
	yGEOhHG4IvbjjZjPfnnGZ6CPiZ4gokvTcXRzDhJvh6mlII0g2m8GZ7w8rqVFmRhYuHg8CQKGJDE
	uIXR/7YzT7WAn9YpJfnhu+7rwjAIHrs5Nl6XRDYGIgD+8N0qo3PXB3QOHAH8YlnrKP/2yfJitgR
	CNZqIFfn3XtQHJMwrNsUrPvKKXdYCLaYUawIXd8RNzwMok4nr4frM80ZSEtQGTOEt4Jo6ZATh2w
	gke48rd1zzP86Hnp9RIXWILIYL2CyBCWOyOStUNU1eDx0Lt/fB8z06lKbAyxtQsNAp3/s7c7/vn
	ssWAalB2VsxBXy9ZgRKxTBryEW0hFmE9uzbOgwwa/KW8/PxfMSmWaHla1T0r5WRFHfJdaQsPsYR
	djrXAMIdDnHYtL0gsvi0RKXa9/VGriUoiw76vWFvIRaNSo4o6x/XrsUtdYdKZ60sTOIIXe9PCI2
	2suEj
X-Received: by 2002:a05:600c:34cf:b0:4a0:159b:d2a9 with SMTP id 5b1f17b1804b1-4a18e4d68aamr114369585e9.24.1791747732221;
        Sun, 11 Oct 2026 12:42:12 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a124-4001-d491-d32f-6b9f-21c5.310.pool.telefonica.de. [2a02:3100:a124:4001:d491:d32f:6b9f:21c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a197c465b4sm89015105e9.3.2026.10.11.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:42:11 -0700 (PDT)
Date: Sun, 11 Oct 2026 21:42:10 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-wireless@vger.kernel.org, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 contextg
Message-ID: <asvjWF8q1injcEIh@gmail.com>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261001075755.3MilPS2C@linutronix.de>
 <ar7vLt5kQ2HJoJY9@gmail.com>
 <20261009160015.9YCN8Lt-@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009160015.9YCN8Lt-@linutronix.de>

On Fri, Oct 09, 2026 at 06:00:15PM +0100, Sebastian Andrzej Siewior wrote:
> > 
> > Source inspection also identified 8139too and macb as candidates: their
> > transmit paths take ordinary spinlock_t locks. I have not reproduced the
> > warning with either driver.
> 
> I just replied to the netconsole thread where I did suggest to lift the
> local_irq_save() part. This would obsolete this.

I've replied in the netpoll thread [1]. The netpoll candidate's RT
locking tests look good so far on Pi 400 with unmodified brcmfmac.

> 
> > The earlier netpoll/NBCON discussion concerns NAPI polling and
> > scheduler-lock deadlocks, rather than this driver-lock warning:
> > 
> > https://lore.kernel.org/linux-rt-devel/20260618111554.2n0pP_O9@linutronix.de/
> 
> There was no fan club behind this change and PeterZ hated it so I
> dropped it.
> But this deadlock should not happen with nbcon or do I mix up things?

No, you're not mixing things up.

> I don't mind if you have something to optimise the driver. But as far as
> the netconsole part goes, I would try to kill it at the upper level so
> the driver is not affected.

Agreed. I'll hold the driver revision while we discuss the generic fix.

The generic fix still doesn't address calls to brcmfmac with
interrupts disabled from non-RT netconsole or atomic writes.

I still need to compare the unmodified kernel and the netpoll candidate
on hardware with firmware flow control enabled (brcmfmac.fcmode=1 or 2).

[1] https://lore.kernel.org/r/asveuLDEf6a44bkD@gmail.com/

Karl
