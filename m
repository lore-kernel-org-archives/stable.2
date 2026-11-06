Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793946763;
	b=VftFaA4JowtP56XbclKIgrMc5ghtv14tLWwDLLlAo5DxUCY1Gp7RMhtWTmHq55j4inoC
	 TaXh0omprcP6zuCZZA90B5Iiy7XdgdyXmPj36pv8onJhl5Pmlma2INGYtjoWtRuIOfb54
	 xwnnmszomi1oYM8zPcdzKLj5NouECKhT1i+Ea0zAVn8f8C37SiUcRBvyAJW6kypSAwV7f
	 3412aixkuHhmBZ6Sb5xdC0545bJunUH0duWNnJy90VQNI94FtVHAACrPSZV0rUqTZoM06
	 jvSgz3PnOTVhJp9TceF3opqmSCLieguhncMPHiEy22OE1E6BmK7dRdSG/maIorM0InA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793946763;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/wPKfZLdL/IZzj15ecN1qG972aE0esZBki0eol8syMY=;
	b=Gwta0bjhaZ4hqkC88SjPUMIpcmCFcxjl8muScx9HMWfSgZ+7kp9/NGPnHSZzC5cuWSHu
	 Nwr020+BusjU0iYIopbDjQSuAKy7yQiEYdsE0nuJ9vdTttkAKgcDV8C9BBJj8ClPiaFYr
	 dnnQ3BJEhqg5ko+CmO9oJjb8ZGMq2vwbpRad6hG0YkRTElZvSUvkfS+0OoznrSiWX/DbO
	 YlmQIMp9DFi/8wuNvG2uaT5SB/xFMBhoiK0gEhLC5jHJLeny/y1t6mHUFPgiHe9g5Ib0w
	 h3sh7YOROZAc+VvodmPnW6TDOJrJB6WAWMvJqRMVdvcDYfmIrAFXUOYucWMzsutuYBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=vNV9pC+v;
	arc=none smtp.remote-ip=115.124.28.221
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF43606A326;
	Fri,  6 Nov 2026 06:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF43606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=vNV9pC+v
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793946757; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=/wPKfZLdL/IZzj15ecN1qG972aE0esZBki0eol8syMY=;
	b=vNV9pC+v6DTaQuE2r7ikzm3Y2cTrTEpLjzfK0B2GWesdu+IGZgg8nomyxIQQxkjCOi3lw59tvBIjzsWs6OEn1Z2Fqj6oT9bfbgajB2emYlJLxLhvrp7Pa0uLo8ep5nojffpzE/hsUKwMEkZWPeIeoGOLi69ADa5B6zq6Kdu/L6k=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2764088|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00278728-0.000457728-0.996755;FP=2717549084337474812|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jy6SOB6_1793946756;
Received: from 127.0.0.1(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jy6SOB6_1793946756 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 14:32:36 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH v2] Input: xen-kbdfront - bound the backend-supplied keycode
Date: Fri, 06 Nov 2026 14:32:36 +0800
Message-ID: <179394675606.2415331.18232448967087865312@xiaopeng.com>
In-Reply-To: <au1xwKh4LVxHyUMW@google.com>
References: <20261106014957.4130059-1-guozh23@xiaopeng.com>
 <20261106020217.48481-1-guozh23@xiaopeng.com> <au1xwKh4LVxHyUMW@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Dmitry,

The threat model is a compromised backend: the xenbus device model gives
the backend write access to the shared ring page for the entire lifetime
of the frontend, and the guest has no way to distinguish well-formed
input from forged input once the peer on the other end is malicious.

Two scenarios where that peer is not fully trusted:

- Multi-tenant hosts. The backend lives in dom0, so a kernel compromise
  of the host should not immediately translate into kernel memory
  corruption inside the guests. Frontends are the last line of defence
  there: every frontend that consumes ring data without validation hands
  the attacker a structured memory-corruption primitive in the guest,
  which is a meaningful step beyond "the host can already do anything".

- Driver domain disaggregation. Backends can also run in unprivileged
  driver domains, where compromising the backend is much cheaper than
  compromising dom0.

This is the same model under which mainline keeps accepting frontend
hardening, for example:

  9b4cf60c6b73 ("9p/xen: validate the response size from the backend")
  d33846c8dcc0 ("xen/pvcalls: bound backend response req_id before indexing r=
sp[]")
  992df081bc88 ("xen/scsifront: check for a NULL shadow entry on a backend re=
sponse")
  808e530654a5 ("misc: nsm: bound the device-reported response length")
  e3046eeada29 ("hwrng: virtio: clamp device-reported used.len at copy_data()=
")

and the READ_ONCE() snapshot in v2 follows the same convention as
8135cf8b0927 ("xen/pciback: Save xen_pci_op commands before processing it").

The keycode here is the kbdfront instance of that pattern: a plain u32
read from the shared page and used as a bitmap index, with nothing
between the fetch and the use.

Thanks,
Guo Zihao
