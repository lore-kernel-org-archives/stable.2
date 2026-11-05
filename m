Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793864849;
	b=MCwQkhkIvlfxZwCl57BfGQgXHK5rz0/YbXiTntVlB6mk9Cp7cW54HE91yz0g4nCYhcHp
	 qQCA7wltLueep3TtK3mf1e2Om+14wLHe9F9HZwHvUqjoG8Mzlih0DT4QMkM+rHuWHCIVS
	 LhwrUjopFi1H29UmnCxWyN7fg48yAoJJh0N23bGV8tQDlL4kTow6U7wzNJ0WH4ZcyIs/Q
	 Q4k1jrdwg/0zVV7kLv0sMhB5YUiF0VyGsU2J7X5qkvui/Z91dfDE51GF1lQAQj+a3ul7i
	 7p5kh7xzZKslVfQa3fueg1utyNElakZmtLWgXLmDButXix640bQCeVmwGtp/88IL5zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864849;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=B/i98e4ur2MMIdQ2EmZkp+68byS444bR54VZZvlNhAo=;
	b=P9hltK83Sd6eQBWI1Cm1RYVrmawD4G5FRrSKXSejEhU3UoE1wL3xYVOg86cBYD9dVOU7
	 xfvWWdtoAI51K02DrTr4r+QTILkGiu2liVYmZST1zA2dURNfF2qXnZxVPhv8K8sqH350r
	 W407jHyvpJ/1DFS7yIKStkhzbPbQV2weCG6lljqHsGzTDG2EiLp2/QnHUiSC7J4EUF4ff
	 yeEH2aSffTqpsg8gHpTSo3ZgPq7ik0B7iq3ulczcXRi755JiCzwn5BbBmFnCktn5hoozp
	 TRf7jl0gz1jNAWKypOlDTinWgblnfmEBQYfBazMrkDWRkpYWe/nz/ry42EvMIzoMlHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=GVUwDSju;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fl54Nrhf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2DC606A31B;
	Thu,  5 Nov 2026 07:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C2DC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=GVUwDSju;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fl54Nrhf
ARC-Seal: i=1; a=rsa-sha256; t=1793864828; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y1Ml22gdy15eOJl1sqyVkoTpLjPQMQ1r3uHoUIee5+dT2+n9GmL4UNy3+LHghOlJuG
    4RQK0Q2fU0om0No70n10lCiI3vNidA/X1GPs9wBDm1VGPeb33ZjSRxvOvWJam6sFolli
    nTB58ViSfquPfntFyraypixnCchTQUbEMBPyC41S2kRgzd/Ru/UcR9b5NhG3lttoTaMc
    +NhndgfMI87vJ6V7aKa98e8X/r8RIjwxL9uZJsJoEI9mqxlJ7+F+Sl9ThVyTRsC8HqVy
    mRAQ8w25liPq5bjoW40z1A4pb+LNDrBLjoVAz32Ubz4j1K9wPXrUM2PQ2+Yhy2A0h5U7
    QCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793864828;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=B/i98e4ur2MMIdQ2EmZkp+68byS444bR54VZZvlNhAo=;
    b=mHAwii7LiPKK00JeIru7f+k/ZPUKE8r/Fq7nLqcMlNP/fl9iVVELnLdwLjzmBvdgyZ
    bQIIH1ktilgUmT9N0k+JzhGa2Au/fU8kSk1oLLawX+zIJOWiZty3jHKVRA0Y1SI0nyJ8
    n7HfScuQts4SqU+aFCICsBzcizmDi/KhCenuFc77FVbw+ZFucvhwELiHB5Kp5uaH0WlC
    HD0p2FMJcpKDo4EUp4qmRN8H8/xiLG3Factaqyi0X3NsniDT9RzZfocdJkZ/4otkwVL7
    2UXdajUPXJouHqo/CtEje7CQlDvvx0aGoedM8G3FrsR3c6a2A5OkV1MBJaKQ9IkM+Hl0
    UXlg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793864828;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=B/i98e4ur2MMIdQ2EmZkp+68byS444bR54VZZvlNhAo=;
    b=GVUwDSjufuFRnedaQq9LAZ3Feixn1T/yl9JKSMsUrInJJ5HhnlyrirB+Ui/b2zR15K
    ovj2RvlcojfZXeyuHlMNHJDrbT+VHS3L7bEDUB1ymZykq/beOquyN1xAwqyz1Z4DRzSz
    eRKlsFoK3ttWDGrxXg+o0EolZ9s9wEEup96iIJ388+j8OF8LOwiTvEXXFiNcMC98TlZZ
    aROdZu59ivBm3Hl+qZTKYdf2SHwHQKi54Vz6qbLqZy0q6R0e56ZyTsl64aQGi+wy6X1D
    uZsX2l9cgKK2bMQ43+zBV+W9cDE7g0q07/HHvMVc4YMQ6lp0nlNSCZom2TD1zutVQ5C7
    qhlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793864828;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=B/i98e4ur2MMIdQ2EmZkp+68byS444bR54VZZvlNhAo=;
    b=fl54NrhfC7hXBtMFvkV52QC0cGeOA61lOHLU7A7AIkaVhk7WnlAPJa2mIDdYYKgKfr
    I+vWYI9nVL3oLEf6vZBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A57l8HNy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Nov 2026 08:47:08 +0100 (CET)
Message-ID: <64f4dfcf-40ec-4838-85d3-a30c3912e242@hartkopp.net>
Date: Thu, 5 Nov 2026 08:47:03 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/15] can: raw, isotp: copy socket options outside of
 lock_sock()
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com,
 s.grosjean@peak-system.fr, stable@vger.kernel.org
References: <20261103204305.3211144-10-mkl@pengutronix.de>
 <179382520924.488856.15425235949830518760@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179382520924.488856.15425235949830518760@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04.11.26 21:46, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch does not remove the RTNL stall it describes.
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but CAN_BCM has
>    the same RTNL-stall problem through a sibling notifier, and the series…
> 
> --
> 
> can: raw, isotp: copy socket options outside of lock_sock()
> 
> This commit moves the user space copies for the CAN_RAW and CAN_ISOTP
> socket options, including the CAN_RAW_FILTER filters, so they happen
> before lock_sock(). raw_getsockopt() now duplicates the filters under
> the socket lock and copies them to user space after release_sock(). The
> goal is to stop a stalled user copy from holding lock_sock() and blocking
> raw_notify()/isotp_notify() under RTNL.
> 
> Link: https://patch.msgid.link/20261027-can-rx-lock-v12-4-eb5afc2d8b9b@hartkopp.net
> 
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index d6517f71cadeb..0926d5686e419 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
> 
> [ ... ]
> 
>> @@ -795,17 +730,84 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>   			  sockptr_t optval, unsigned int optlen)
>>   {
>>   	struct sock *sk = sock->sk;
>> +	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
>> +	struct can_filter sfilter;         /* single filter */
>> +	union {
>> +		can_err_mask_t err_mask;
>> +		int flag;
>> +		struct can_raw_vcid_options vcid_opts;
>> +	} val;
>> +	unsigned int size = 0;
>> +	int count = 0;
>>   	int err;
>>   
>>   	if (level != SOL_CAN_RAW)
>>   		return -EINVAL;
>>   
>> +	/* Copy the option values from user space before lock_sock(), so a
>> +	 * stalled copy can not block raw_notify() waiting for lock_sock()
>> +	 * under RTNL.
>> +	 */
> 
> [Severity: High]
> The comment says a stalled copy can not block raw_notify() waiting for
> lock_sock() under RTNL. Is that true for the socket as a whole?

No. The comment and the commit message refer to the CAN_RAW and
CAN_ISOTP specific socket options. The commit message explicitly states
that the generic SOL_SOCKET options in sk_setsockopt() are not affected
by this patch.

The SO_ATTACH_FILTER copy under sockopt_lock_sock() is generic socket
code and not specific to CAN. Before this series raw_setsockopt() even
held RTNL itself during the copy of the CAN_RAW options. This patch
removes the CAN specific part of the problem.

Avoiding lock_sock() in raw_notify() and isotp_notify() under RTNL
altogether would be a redesign of the notifier handling, which is not
suitable for this fix and can be considered separately. The code
comment can be made more precise ("a stalled copy of the CAN_RAW
options") in a follow-up for can-next, if required. But I think the 
commit message is enough.

> 
> The same bound CAN_RAW socket can still hold the socket lock during a
> user copy through the SOL_SOCKET path. sk_setsockopt() takes the lock
> before it handles SO_ATTACH_FILTER:
> 
> net/core/sock.c:sk_setsockopt() {
>      ...
> 	sockopt_lock_sock(sk);
>      ...
> 			ret = sk_attach_filter(&fprog, sk);
>      ...
> }
> 
> and sk_attach_filter()->__get_filter() then copies the program from
> user space:
> 
> 	if (copy_from_user(prog->insns, fprog->filter, fsize)) {
> 
> SO_ATTACH_REUSEPORT_CBPF goes down the same path. On the getsockopt
> side, sk_get_filter() calls copy_to_sockptr() under sockopt_lock_sock().
> That is the SOL_SOCKET equivalent of the CAN_RAW_FILTER copy this patch
> moves after release_sock().
> 
> Suppose fprog.filter points into a FUSE or userfaultfd backed mapping
> that never resolves. On NETDEV_UNREGISTER or a netns change of the
> bound device, raw_notify() then waits under RTNL:
> 
> net/can/raw.c:raw_notify() {
>      ...
> 	case NETDEV_UNREGISTER:
> 		lock_sock(sk);
>      ...
> }
> 
> As far as I can tell, net/can/ has no capability checks. That would
> make this reachable by any local user who can create and bind a CAN_RAW
> socket.
> 
> The commit message says "The generic SOL_SOCKET options in
> sk_setsockopt() are not affected by this patch". It does not say that
> the RTNL stall is still reachable on the same socket. No later patch in
> the series changes net/core/sock.c or net/core/filter.c.
> 
> Would it be better to stop raw_notify() and isotp_notify() from blocking
> on lock_sock() under RTNL? The other option would be to also move the
> generic filter copies out of the socket lock.
> 
>> +	switch (optname) {
>> +	case CAN_RAW_FILTER:
> 
> [ ... ]
> 
>> +	if (size) {
>> +		if (optlen != size)
>> +			return -EINVAL;
>> +
>> +		if (copy_from_sockptr(&val, optval, size))
>> +			return -EFAULT;
>> +	}
>> +
>>   	lock_sock(sk);
>>   
>> -	err = raw_setsockopt_locked(sock, optname, optval, optlen);
>> +	err = raw_setsockopt_locked(sock, optname, &val, filter, count);
>>   
>>   	release_sock(sk);
> 
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch, but
> CAN_BCM seems to have the same RTNL stall through its notifier.

Right, this is a pre-existing issue that is not introduced by this
series. CAN_BCM does not use socket options at all. CAN_BCM (and 
CAN_J1939) notifier handling will be looked at separately.

> This series does not address or mention it.
> 
> bcm_sendmsg() takes the socket lock and then dispatches to
> bcm_tx_setup(), bcm_rx_setup() and bcm_tx_send(). These copy the CAN
> frames from the user iovec while the lock is held:
> 
> net/can/bcm.c:bcm_sendmsg() {
>      ...
> 	lock_sock(sk);
>      ...
> }
> 
> net/can/bcm.c:bcm_tx_setup() {
>      ...
> 			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
>      ...
> }
> 
> bcm_notify() takes the lock for every bcm socket in the netns under
> RTNL. It does this before checking whether the socket is bound to the
> vanishing device:
> 
> net/can/bcm.c:bcm_notify() {
>      ...
> 	if (!net_eq(dev_net(dev), sock_net(sk)))
> 		return;
> 
> 	switch (msg) {
> 
> 	case NETDEV_UNREGISTER:
> 		lock_sock(sk);
>      ...
> }
> 
> Say a BCM socket sends TX_SETUP, RX_SETUP or TX_SEND with the frame
> data in a FUSE or userfaultfd backed mapping that stalls. Can any CAN
> device unregistration in that netns then block RTNL indefinitely?
> 
> No later patch in the series changes these paths. The only bcm.c
> changes are proc and can_rx_register naming.
> 
>>   
>> +	/* on error free the filters allocated for CAN_RAW_FILTER above */
>> +	if (err && count > 1)
>> +		kfree(filter);
>> +
>>   	return err;
>>   }
> 
> [ ... ]
> 

