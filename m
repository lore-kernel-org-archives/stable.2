Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481678;
	b=pWbymUi54Wx615nGFon0sKxXj4S2oPOFT+ETrtKBPFkXg/GyFWlGAIW/UxBXP6yIg2F6
	 p1HUVA5z1AcVNBe98QrjZh93l6kHBSBjCkzBBQuDss4qu7W4HYkxy2Mr6qRD/0UuTjNYG
	 SCATyjmQDaISI5l9fhulnJuDSTdVAhLuX8+TUdkxs3wv3HvvnwsmnWjckrxyUYrtrY3XX
	 A8JQaHS40YWHz5ScwcD2YVoejL2sKnj4e+jZq1YULXXHcJVQJ2idSBTYKgTX6OXf9WjiV
	 iKk2sZ+6nbRCI/tvE1lcGQNPp3iTpihnY8pnyCj1/Y9YS9X0ltFQb6JKHu8f1WwUMlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=wxrFEQwvZofo98YP2I+hr7iiAcbc0NkcdEgkCb5+KYc=;
	b=F2D377Yk/nqnHcCnk/DUfFu0Td//MFbDdMAuShf09mofiYHmtmUFjMSN/1osNTlBFEyy
	 iEK23MRdxUV1bdZ7K3ODDcLHV3y5FrCVYBA2KOwW+YoRcpuK+ye798a3v6xYuFY18lF9u
	 IyE5kTLsdB1nedikdtS0z5wfbtibBrZFouRqpCBJF9x7rzDp3MESBE12khDww587s22BU
	 /ZzyrNK30apampwM9Ii/WE7nG6usij72HXo/5anYFTl2lJ+IU8SNaCSV4yo/gpgmvi568
	 OIrNxHZmqF6y/MPpBz+kCSSpuYWHk3kf3gRAHzKzB/jsCqSCW/iTiSXHar9LFBJiZ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qAcOTgh2;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A370606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A370606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qAcOTgh2
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f041f88577so21350735ad.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795481677; x=1796086477; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wxrFEQwvZofo98YP2I+hr7iiAcbc0NkcdEgkCb5+KYc=;
        b=qAcOTgh2VKFtxARfCG/NRj9gEnV/2YBjyx3if8vZj9CWMZcf7B1w76NAPf996jOFz1
         WLKsLHm/CZV2RcJ2qbELKcm3x6eD5BrvPRphgxZyfnNox16h7XHP6lA/roVNbkL93v7t
         kezG2HXPtXbMRLPS3Ix/DS79BlBb7rYrUkjaIhRkN+9jTzAn4Y2yNriQNBrCzH/36lH7
         BRY/zWsGEm6bb6BnDptS40PBFQT3UZYhtBdxp6kKmaYEzQj2wZnC7+0xdz4iCrEsdht5
         2TPV7G2QSaLuko6z7lsSxxAd9qDRt8dZla88vlsvt9Uwpb5adJUauP5ZG2EdMKFW2a5P
         jukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795481677; x=1796086477;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wxrFEQwvZofo98YP2I+hr7iiAcbc0NkcdEgkCb5+KYc=;
        b=wpJnYQe5Ni0rcLCS5XaABJ3hx4k/SvdIfxEM1UZzPvfqymCTssAhrg/af1Qgvsj6Xk
         V43rg1//LXsCOTyxvXeqNjCM5fVc9xEPeOcAcEDcEVBLpwP6Pqiwqmi3m0k3DQCZbK5p
         WL9gBKl5eVJipGFveVkcDC/t2IyC+Ij0b6xnu4+viQLnPfvlOBfIOMejWIoF5tCtlnjK
         tvfFHxdayC4I4kqO7j+PHM7zh9ofQEbTts/8F6QxDH4EVHhHQIdbjdk2Fxj57UErpOFA
         r0+LciwpHyL8V2t9vwoeKgMWLOYUbGFazpBkF+FHbFp3rB97MydxsMW9pw2ceO41bCB2
         FKFw==
X-Gm-Message-State: APuU4Z9DBQVcuaTH4SMJ4RJ+atbK/Pb32l8Ym8zkoQXzMgtX7FOxFmfb
	PQxS92YyqGB8zNVZJLCpwj3i347HAtNH7DYZ0wnCPqN3sqkthg4kFW8qVgRgXfKd/g==
X-Gm-Gg: AZFdTZfWvv1s3UgpXesUv6CL8TKpyZcpQGsWfMEZ50KY0heDNEvYFPCvF3n/6V1ZSJI
	/LXY2DFXGOkixm3/oL24Q4TYkNjtMOKf5vYdk1vMe16v0NLwf+zTVu8pkj4UeuY2d71H1YvlfEa
	f+CjMEMHDTjrkugKLlry8FnkJc3dxbg7DdhM1Jta5iG7nZGa65W7IKDrx6NNtqGCD3Y+FICb9WO
	NCkNMWTkqu9i1hFoQ683VA956Jn9eEcjgQVYLFmkRKZhkSq7kjHaciJaVLBITceLSAZC18tknvr
	h7JNgWT+eAxTZIhuYBozKN0ZySn4gFgN0UEFLsFikwWzPR9biJYtz95DdUoqZg7mXa0Cc3o3THO
	r5IfbVz4WJ3JZ1D8uMuQYPTPwVuvNJSoKfADQzfBD41pBzPw0yk5rulOTaP0MFrNk0mp/MnBTGp
	PY79tf79luzoKNXSv2Nf1/fg7XEUyDB/ri/fXwHohSQxAiVBeVKScMOP6+dVKugt+d2GDhoxfLQ
	WQk+/gCW8rwWRWG+oddTk7E0u3ii0+nad16jPKs2WEfeGRqcLeBk6Ai6aQQLwicC+hxx2M7aRfR
	y/uhhne+2E/iU6dDuLn1dOYLRMwGrCId/63DikEWjFI65ghF+fNRbcMo82ffZLvF
X-Received: by 2002:a17:903:2a88:b0:2f0:4fa1:9661 with SMTP id d9443c01a7336-2f04fa19715mr99857965ad.18.1795481676747;
        Mon, 23 Nov 2026 16:54:36 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0817ab27fsm30599975ad.35.2026.11.23.16.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:54:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 16:54:35 -0800
Message-Id: <DN314UP7ZLCR.39N4XNGLWKR05@google.com>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH v2 07/16] PCI: Serialize bridge window sizing and
 resource assignment
From: "David Matlack" <dmatlack@google.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 <linux-pci@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>, "Rob Herring"
 <robh@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Williamson" <alex@shazbot.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>

On Fri Nov 20, 2026 at 5:47 AM PST, Ilpo J=C3=A4rvinen wrote:
> +/*
> + * Serializes bridge window sizing, resource fitting, and assignment.
> + * pci_rescan_remove_lock cannot be used for this because BAR resize and
> + * some drivers run these operations under device_lock() during probe.
> + *
> + * Context:
> + *  - Nests inside pci_rescan_remove_lock and device_lock().
> + *  - Nests outside pci_bus_sem.
> + */
> +static DEFINE_MUTEX(pci_res_setup_lock);

Hi Ilpo,

Could this lock live in struct pci_host_bridge instead of being global?

As far as I can tell, a sizing and assignment pass never goes above a
root bus, and root bus windows are only allocated from, never modified.
So passes on different host bridges never touch the same resources.
Every entrypoint has a pci_bus or pci_dev to look up the host bridge
with, and pci_assign_unassigned_resources() already goes one root bus at
a time.

To be clear, the lock wouldn't protect any fields of struct
pci_host_bridge itself. It would protect the resource[] entries of the
devices below the host bridge, and the BAR, bridge window and Resizable
BAR registers they mirror. The host bridge is just the smallest object
that contains a whole pass.

My motivation isn't performance. It's that global locks make it hard to
tell what data they protect. pci_rescan_remove_lock is a good example:
it's held around runtime rescans, but not around enumeration of ACPI
host bridges at boot, and that was confusing when I was working on PCI
Live Update. This is a different lock, of course, but it would be nice
to avoid adding another global lock.

I tried it on top of this series to see how much it changes. Only this
patch is affected. It adds a mutex to struct pci_host_bridge,
initializes it in pci_init_host_bridge(), and uses a small helper in
setup-bus.c:

  static struct mutex *pci_res_setup_lock(struct pci_bus *bus)
  {
  	return &pci_find_host_bridge(bus)->res_setup_lock;
  }

All of the guard() sites and most of the lockdep asserts already have a
bus or dev to pass in. __assign_resources_sorted() only gets a list, so
it would have to assert using the first entry.

Putting the lock in the host bridge would also make it reachable from
remove.c. pci_destroy_dev() drops pci_bus_sem after list_del() and then
calls pci_free_resources() without pci_res_setup_lock. I couldn't find a
path where this can cause bugs, but that seems like just a lucky
side-effect of the current code. It would be nice to have the new lock
explicitly cover that case too.

This is not a blocker by any means, just wanted to get your thoughts.

Thanks,
David.
