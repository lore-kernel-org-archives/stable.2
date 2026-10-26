Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008844;
	b=CFA5B7Gxx2DKcUOhDzV00DQf9JMgZ4ZEJroCfjluz2zs2QypdW1MqwxH9f7GkXsb9xkn
	 srI6elKRsYsqkcm7x6FgmLVr37fvRFTfw9LHO3AZ8tH633eHiSYU/gRs3gu4K2MdgHNFz
	 70EGnarAjuu81y1tsk0xh4cxmjj+Cd8NDIUZRWGmyIkIDqannyDy8Sf/PQDEMBSIu5wMN
	 qyTrUX4in78OnDF5p2sNutyNw+ekl9u+c+u3Nb5DJvs+JBl5eJwGIapZDBGKkLq2ctYvt
	 W2rHvfTz+OSA52uFEfbPAWdcSKdyXlS4UDJ7I5yeQSjAgctpYZbO0KNuOGyV14iCuZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008844;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type;
	bh=h3r2il0H80lLq9FBEl/2Zbfsq/ZTHqoGrukJv/jcN5k=;
	b=Il60zPRt/uSQLviUKRDtAYLSuhQb3zMuZKs945ZUMPlSxSr1jN/tZgCFjjGD4vs8I/2A
	 0OM0olkUMfm5kV5wRwP88OdK9j+/m1ccjR5PMJeGlsRRJPyDUr/lq/O3n3JUAz5giEA/s
	 S9JcQmJPWWGpFOYe3C4qDvXvJ6ZGAHGOu2Ttn3UUUUDW/OuvHjidYvYY0566nvOcpr42/
	 qjYJ03mjcqCPl3iEQv68qUaD5i8vGyfDkJBl+WgR1JcnxeAht711ETlJTjHgyuStU2DNb
	 XhNemtDWDW+LwADZOQ16hE28aNmTCOS9iwA2Mv/8xoMPLG2rB3qzFZgyZKSIc20jDQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E8606CF86;
	Mon, 26 Oct 2026 10:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E2E8606CF86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Bruno Bieth <bruno@bieth.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [REGRESSION] ath9k_htc: AR9271 can't be brought up (-EMSGSIZE)
 since "wifi: ath9k: reject short WMI command responses"
In-Reply-To: <179300633675.74151.170245467704180950@bieth.org>
References: <179300633675.74151.170245467704180950@bieth.org>
Date: Mon, 26 Oct 2026 11:00:38 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ecdcpyrd.fsf@toke.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Bruno Bieth" <bruno@bieth.org> writes:

> Hi,
>
> After updating from 6.18.48 to 6.18.56, my AR9271 USB adapter
> (0cf3:9271, ath9k_htc, htc_9271-1.4.0.fw) still probes fine, but the
> interface can no longer be brought up: every attempt fails with
> EMSGSIZE ("Message too long"). On 6.18.48 the same adapter associated
> without problems.
>
> I believe the cause is the 6.18.56 backport (e0c21130c1c7) of
>
> 93ce8ea70451 ("wifi: ath9k: reject short WMI command responses")

Yup, this was already reported, and a revert is in 6.18.58. Please try
that.

-Toke
