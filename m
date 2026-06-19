Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2191FA859
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781905103; cv=none; b=CcZ5kC0q/atnTxXKmvCoCW3mSivb19pIb0ZlhH4eJQpDh1f2Hj66rnVNQABy1WWA7V2BmAyjfhOgxpQPK1XN5xg1Unt/DdCv5zGwTmTXW0BcNvZMhSmC4Smw4kkgfpgF1mBeyjPeye8QP2Yx/a6Nwvynx+mZiR/6kUfNPjCUPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781905103; c=relaxed/simple;
	bh=aTMx4fShMFM7yxIE30jLqxwcU9dlIxvXtF4rQlgVT2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipw64dWSAIRFkvc1079Iomvjv2t7SIzkyoyy090GKb/pIMagdYg16AzXQt40tra/p48mYY6u71umYsLfMLgjVebMhbbl+diChHD19YvIhlT0iI0lN0a2yA2JquU+5DFWkyy9j+Njtii+F6gJNuyUgEUgAx5SfRgngwIcJnvRLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=n1C3qiCp; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="n1C3qiCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=5096; t=1781904730;
	x=1782509530; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Autocrypt:Organization:
	Disposition-Notification-To:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; z=Received:=20from=20[IPV6=3A2603=3A7
	002=3A100=3A8400=3A482b=3Aaa20=3A950d=3A90aa]=20by=20auristor.co
	m=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=
	20PRO=20v26.0.3)=20=0D=0A=09with=20ESMTPSA=20id=20md500100538363
	6.msg=3B=20Fri,=2019=20Jun=202026=2017=3A32=3A09=20-0400|Message
	-ID:=20<c0fd4fec-1576-4070-b31e-a37d5506f5ed@auristor.com>|Date:
	=20Fri,=2019=20Jun=202026=2017=3A32=3A38=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PAT
	CH=20net=20v2=2001/10]=20rxrpc=3A=20input=3A=20reject=20ACKALL=2
	0outside=20transmit=0D=0A=20phase|To:=20David=20Howells=20<dhowe
	lls@redhat.com>,=20netdev@vger.kernel.org|Cc:=20Marc=20Dionne=20
	<marc.dionne@auristor.com>,=20Jakub=20Kicinski=20<kuba@kernel.or
	g>,=0D=0A=20"David=20S.=20Miller"=20<davem@davemloft.net>,=20Eri
	c=20Dumazet=20<edumazet@google.com>,=0D=0A=20Paolo=20Abeni=20<pa
	beni@redhat.com>,=20Simon=20Horman=20<horms@kernel.org>,=0D=0A=2
	0linux-afs@lists.infradead.org,=20linux-kernel@vger.kernel.org,=
	0D=0A=20Wyatt=20Feng=20<bronzed_45_vested@icloud.com>,=20stable@
	vger.kernel.org,=0D=0A=20Yuan=20Tan=20<yuantan098@gmail.com>,=20
	Yifan=20Wu=20<yifanwucs@gmail.com>,=0D=0A=20Juefei=20Pu=20<tomap
	ufckgml@gmail.com>,=20Zhengchuan=20Liang=20<zcliangcn@gmail.com>
	,=0D=0A=20Xin=20Liu=20<bird@lzu.edu.cn>,=20Ren=20Wei=20<n05ec@lz
	u.edu.cn>|References:=20<20260618134802.2477777-1-dhowells@redha
	t.com>=0D=0A=20<20260618134802.2477777-2-dhowells@redhat.com>|Co
	ntent-Language:=20en-US|From:=20Jeffrey=20E=20Altman=20<jaltman@
	auristor.com>|Autocrypt:=20addr=3Djaltman@auristor.com=3B=20keyd
	ata=3D=0D=0A=20xsFNBEwLlO0BEACu6yWFkd1+qwsGg8ZzgslSkcAKhSegWt5j8
	6DpaRL0W8fxg6YjxwEPvwoH=0D=0A=20BGa/rpSdBd1gkmzeYxD3hVZdj75r6nVS
	9f/mxNQzW+o1sW4vaeSxKgZSQz5RqHmwPDcqQP66=0D=0A=20+ZSnjV+G88MKwZ9
	DIzA9AwpJhNAAlAlj3OvsQVsxd1ipc6C4/U3qjHL7Ih22UbPBM71ltIZx=0D=0A=
	20kqcrAlXPnUTeraJXtfzYbq4mJFJ9JC6/o1NRSjsBvRD+ADxlG50+KccZN4SS5x
	xdGuh1tA9U=0D=0A=20TydYBQB3YtJbq7CYau2kIYt/3HnyLYGo1s6Ti6cuAJJ/4
	0iIE1xkqhvMiIz/Q+1ztmksJbLQ=0D=0A=20aCtW8kF42nF8MpPdIPTSPr2uGvpR
	tCjRbh4lgMXgyNUx1wpCEY0X11xce++H8HySmFwryE2y=0D=0A=20kkxUQeMUjaa
	XZDHYUSyQz7riChFiZ9ax9dmX0wUY/A05v0qcualglpk4wJ2kcsGKUEGkLvnV=0D
	=0A=20wwvya8zifPwKOw5JlGPvzX8t2m7jB2GXKzvVAsImqOqnDBTKUXWQQZCW9R
	qt7acdE8bQ2vqr=0D=0A=20vP+3Ykf4SrPwcuNCDt6QSgjVbhc3hA3hCtE1iW/Hh
	uBAzKiuzJ9era+q9QjTtLPIkQDHRpcC=0D=0A=20MMWvK0Y1uQ34Ql1BfKRA4gc8
	A7CuVUY6+Ga7PuJWd+FSglvmKQARAQABzTZKZWZmcmV5IEFs=0D=0A=20dG1hbiA
	oQXVyaVN0b3IsIEluYy4pIDxqYWx0bWFuQGF1cmlzdG9yLmNvbT7CwXkEEwECACM
	F=0D=0A=20AlY2YwgCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRD3en
	NVkraaBDdzD/0XQUDW=0D=0A=20UWXrpapHdvZaHzPHc3xobRi4PABWfLW1jfMK5
	Xy4DP/x7x3I2qAqTD6vv/OPFMx8gG6+Xeod=0D=0A=20Mj5vE7+7ZRd+J76J4DJH
	2qoaXX8qnUEABUJHZYDhw2/Ij5AQ6ZsuSwXuURGEMi0vu1ihBbP6=0D=0A=203bt
	4LRIa+F60ebDvCl9po+UB7TrjQCs+YV1r1YeCSv9hEHBly/W0u1OrnNCMWRcq7dm
	TCbZ0=0D=0A=20R5w6VJ/+QEio+T6paGGMjJmrNw2qUeuK+SxOOxOWS8lgdqzjcK
	3NsfiERrVbOWM83ZVy0/GN=0D=0A=20vpusjhI/3Q8lbV/p+IsJk/v1grkRzgU0f
	rES2ANEPTpC4j2ggPOSMpsz3BZ8wIOg17rIWnK+=0D=0A=20gNLQe+XN7kvDwGu0
	jYhTIZO10jcVsRSrAJGtgBNrYxOjEUhpnaSJDVcjapRvRPCQumA13Zkl=0D=0A=2
	0nm4AYjp7L2oOIeOGcKRZwbrGDakksa5iaSIoywpwECWh2l9V0W3SeynBgPtR4qp
	t4N8yKCcw=0D=0A=20suLCAKfBv9RcL641XZi/Fp9btSuTPUm5Lw3SIGr5U+Syez
	mhzlwsObIF9W624aorriWoXNf3=0D=0A=20GgH9ZH0Hkc6aS99pIZhh5USWRO/pS
	+lv5eNkEdf9LUBGX9b6ZMan0fpoEayqUejtZw3O2rgs=0D=0A=20zA+pTSA+/Hob
	vtL6L3XtlPJ1NXlkgM7BTQRMC5TtARAA88hJdpgcg2RU/uAWfAL46XZHA59c=0D=
	0A=20VpPNNly1tPWCSbG6+ONH6nOG/NarmNVxX6Mb9YRkEU6wmrZS85inz3otdyz
	/zlyNSWma8qGN=0D=0A=20UlMbiwFQqfXWVBAPGoRC0a0aJrd4IayLuvv1UqEwx7
	Otp7y5RNHtRv35/kho0Z+UheYVdGm2=0D=0A=20I06xIc+aNKW2LO7R5BNtjpADP
	IG+NSdsVIeamhAWPvLrwbf6mUb//eA9pF0w0QixLVrH/cCo=0D=0A=20z+S27gCG
	JvY6zF22NgdhnkIqNz8E/LKt6S36ZI9Mw/ixpQTozqRmdNzVQNgTHUZClbJj4iq1
	=0D=0A=20EPHB7XqpxOv+awrxSxq2jt8GFD0rU+sAuzW+F7cBoIw434/IrxKYwcP
	HpHLEVQ1tLP7d3ZpZ=0D=0A=20R30p3oqoliGiLsWvHHxyXjuMBF4XJ6MRXmD65/
	qOhuo2DKduHMNlmxzgSzvWgXZeNJq+OcS8=0D=0A=20jQZDt2Na2pMKjWytau7xQ
	u2ndm0FwS48ngMrDYRQMxzL1NfnBnT9BCwjiU+/6NBSwcNKIqye=0D=0A=20a9Ip
	TwsVfkF4/iui7xD9+LtzqeUkBAe7q5jEJmJMZhAfh7usZGT8TGxXegCaF4Jwz2nx
	S4Fv=0D=0A=207VRza/yUAOJlc0daR11TPeiUNCQWY7PpL1AXO9vaSyjFuOzTnU8
	vzXvI9fGoxIxKGRQpKMU8=0D=0A=20PROIFw0AEQEAAcLBXwQYAQIACQUCTAuU7Q
	IbDAAKCRD3enNVkraaBIxXD/4xlaBwW2TLFfMv=0D=0A=20lcY/2XDSm6NO4JaJG
	2Nzp35xaaBVwMVzWvI+GgTgKNSFot9f4jiLBNQdnq3UKoEThR2ORKVL=0D=0A=20
	0ZJS1QYR7yyrOo0MteDSy8ofU1FJ6xu4ND3ekOjP20BTrihDpqUdahir2uaRfMkw
	M+0imOlc=0D=0A=20utGMhJNF/LAjrhoDp9SeDMYBXZ1wfrbrEo/EEu0PbkGyzqP
	yEPqwN1iSJkcAnjuIA0rTf1jQ=0D=0A=20tJAaDov7yHsSRwUM+qTGsjOGQAN3wt
	YwjPpw7hI01sE+x0uq0pVeo4qeWTZ2TE4Vtp8FKXFA=0D=0A=20kqnP878q+kNk9
	Ve+DRs8UlRfa9Lgf5ETjXOTVGaT/UGxi9B4oo8k0lzvM/A1txexL/lLw8AU=0D=0
	A=20LhUeGtyS6D2X9vFi6azna+o918R9BV86uXPiDOf1nMwqKchNCxmgH9vd0aQm
	8TKCrWAW4kU1=0D=0A=20Ig6aMNuZiWloVZfKrmWizbgeGKE9rhNPNqxkqBaA4lr
	J8L6bdKbhAOe3NQjO2vUAXB53Jphl=0D=0A=20F74GwEsh+85i9/yIbvwJVcsFYh
	dZz7fCAUOcnFkGnyrwIgkizQ3xXShPW8mqkgUk4kYMnucC=0D=0A=204kG/E7pI/
	4lke5X5X9vroXRHB7tkpAgT46SqSM/XTwCaseXG9orDgz3duRTUp6K0++S/qsqT=
	0D=0A=20akGVmjD5917A1HqWfMmiKA=3D=3D|Organization:=20AuriStor,=2
	0Inc.|Disposition-Notification-To:=20Jeffrey=20E=20Altman=20<jal
	tman@auristor.com>|In-Reply-To:=20<20260618134802.2477777-2-dhow
	ells@redhat.com>|Content-Type:=20text/plain=3B=20charset=3DUTF-8
	=3B=20format=3Dflowed|Content-Transfer-Encoding:=208bit; bh=GfM/
	E7NYy0tPCz4InFMotGQMZR3cNn5x8g+HdoCHvX8=; b=n1C3qiCpikKs0HY13SSw
	oJT1HJKRJwimdJo23SfpFPGYOzyXcmkP8ifapVf7PgnEolBCUHI0YTiHomoadOGz
	UNTqzwBJaj6Qg/vvaneGguo9iYFUzB+r8aN4k8ZcRO6UpDrhOKVKgrMrMDilpcJU
	Ks5cuRdvTcHNbHf2VoLhlNk=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Fri, 19 Jun 2026 17:32:10 -0400
Received: from [IPV6:2603:7002:100:8400:482b:aa20:950d:90aa] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.3) 
	with ESMTPSA id md5001005383636.msg; Fri, 19 Jun 2026 17:32:09 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Fri, 19 Jun 2026 17:32:09 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:482b:aa20:950d:90aa
X-MDHelo: [IPV6:2603:7002:100:8400:482b:aa20:950d:90aa]
X-MDArrival-Date: Fri, 19 Jun 2026 17:32:09 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1630b1736d=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <c0fd4fec-1576-4070-b31e-a37d5506f5ed@auristor.com>
Date: Fri, 19 Jun 2026 17:32:38 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 01/10] rxrpc: input: reject ACKALL outside transmit
 phase
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 Wyatt Feng <bronzed_45_vested@icloud.com>, stable@vger.kernel.org,
 Yuan Tan <yuantan098@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Zhengchuan Liang <zcliangcn@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Ren Wei <n05ec@lzu.edu.cn>
References: <20260618134802.2477777-1-dhowells@redhat.com>
 <20260618134802.2477777-2-dhowells@redhat.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Autocrypt: addr=jaltman@auristor.com; keydata=
 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
 akGVmjD5917A1HqWfMmiKA==
Organization: AuriStor, Inc.
In-Reply-To: <20260618134802.2477777-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDCFSigsAdded: auristor.com

On 6/18/2026 9:47 AM, David Howells wrote:
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> rxrpc_input_ackall() accepts ACKALL packets without checking whether
> the call is in a state that can legitimately have outstanding transmit
> buffers.  A forged ACKALL can therefore reach a new service call in
> RXRPC_CALL_SERVER_RECV_REQUEST before any reply packets have been
> queued.
>
> In that state call->tx_top is zero and call->tx_queue is NULL, so
> rxrpc_rotate_tx_window() dereferences a NULL txqueue and triggers a
> null-pointer dereference.
>
> Fix rxrpc_input_ackall() to mirror the transmit-state gating already
> used for normal ACK processing, and ignore ACKALL when there is no
> outstanding transmit window to rotate.
>
> Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>   net/rxrpc/input.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index ce761466b02d..37881dffa898 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c
> @@ -1214,8 +1214,22 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
>   static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
>   {
>   	struct rxrpc_ack_summary summary = { 0 };
> +	rxrpc_seq_t top = READ_ONCE(call->tx_top);
> +
> +	switch (__rxrpc_call_state(call)) {
> +	case RXRPC_CALL_CLIENT_SEND_REQUEST:
> +	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
> +	case RXRPC_CALL_SERVER_SEND_REPLY:
> +	case RXRPC_CALL_SERVER_AWAIT_ACK:
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	if (call->tx_bottom == top)
> +		return;
>   
> -	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
> +	if (rxrpc_rotate_tx_window(call, top, &summary))
>   		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
>   }
>   

Wyatt,

Thank you for identifying the NULL pointer dereference but I do not 
believe the patch is correct from an RxRPC protocol perspective.

The rxrpc protocol is not formally standardized.  Linux rxrpc is a clean 
room implementation of Transarc/IBM RxRPC protocol used by AFS 3.0.

I've been spelunking through old source code trees dating back to 
mid-1988.  The original usage of the ACKALL packet was a form of delayed 
acknowledgement only to be sent after all of the DATA packets inclusive 
of the LAST_PACKET had been received.  Your expectation of how the 
packet type is intended to be used is consistent with that behavior.

However, in Nov 1988 the DATA acknowledgement logic was altered in a 
backward incompatible manner.   Instead of immediately sending ACK 
packets in response to every DATA packet except when the final DATA 
packet inclusive of LAST_PACKET was received, the ACK packet usage was 
extended to permit delayed transmissions. From Nov 1988 onward ACK 
packets were scheduled to be sent with a 200ms delay unless the received 
DATA packet was a duplicate, out-of-sequence, out-of-window, etc OR 
unless the received DATA packet had the RX_REQUEST_ACK flag set.   The 
delayed ACKs replaced the ACKALL usage in the general case.

But it appears there was a bug introduced which resulted in the sending 
of arbitrary ACKALL packets at any point in the call lifetime.   This 
bug was not identified until Nov 2001 [OpenAFS 
db2ddfaf1b322710e1bd4edce6d7519157c3c9eb] at which point the sending of 
ACKALL packets was further restricted.  One of the reasons why the 
sending of ACKALL packets at arbitrary times was not identified as a 
problem for more than a decade is that ACKALL packets received when 
there were no transmitted packets waiting for acknowledgement had no 
impact on the call state.   If there were transmitted packets waiting 
for acknowledgement and they were successfully delivered, then the call 
continued successfully.

OpenAFS 1.6 pre-releases attempted to resume use of ACKALL packets as a 
performance enhancement only to revert the change because of 
compatibility problems.

I think the best change at this point would to accept the ACKALL packets 
without generating an error regardless of the call state. If there are 
transmitted DATA packets waiting for acknowledgement, acknowledge them.  
If there are DATA packets which have yet to be sent, leave them alone.  
Only complete the call in response to an ACKALL if the ACKALL is 
received by the acceptor (incoming call) and all DATA packets inclusive 
of LAST_PACKET have been transmitted at least once.

Sincerely,

Jeffrey Altman



