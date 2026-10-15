Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801FF3E2AD6
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078348; cv=none; b=UNjsT8HH0itXTsW7/bWP+aGUTtkbhJbNtOVKQTF+IB2MeOhe/TY2AIuEMtnsKmnJZU/cnyVXV/zhPHvEwFD8uWGkuCN4swPcuFu7QNTWtyivcUboi6RnS88i7xBbBHH8gt/WLmr42mNX9gZGvqU6GYuGOfxqOZ9E6fHqYEgHyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078348; c=relaxed/simple;
	bh=dRQxOY6M1ZTR87IcuIO6396JUP83HtzoNMA4wDPwxjY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UkcwlN5A72pHhyICueqff6dn2jbH7AirzHeHiPk/dutbaDZOoputU31WMIOhFOYMcV3ooKwwzrjwGBFiTdeJNFqGuQyMxD5CQ9ul4AUQur1r+ncr45P0bE8ppboloio6Naq5+Y8YzTbNUnb+Y/LUJ/HlKPy90L7vNeLNyTYQuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kf/Z7BZF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf/Z7BZF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-88c72646f03so1013038b3a.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792078340; x=1792683140; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=crx1YR/SfB41hfDYmI9jxzk8Ryxa8Ve/h/yCnmWkATw=;
        b=Kf/Z7BZFPZYcwHTR4ASY1TzCIV6BjPEoiHAjoKKBdBG0sCya9g+pUYnGFJL4q5P+4d
         G1gNFgokjjIu2AHxHexHsNpbCOXJ85y6GXlXIxoJP7SRzAr1WOxj5Gxj47VgUqQyWnUp
         iWxyo25lGZiH+R00KbMapbXpiiiG3pEwrTaH/4TEjzCo5YryJONnM6iqFGrV6pyeFQV/
         h6vDBzMTVCy4Ww1SAR23WPcKHG6MxIzea7C70GgXVBgP34YxYfZi+o9lqjiz2C3GJcKM
         +/R4ON/HbgirZ6FYkZu4mIAHtaxqLTeL5+LQlZX2TP5773rZg8i8E347bMQigl+1nuE3
         ReIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078340; x=1792683140;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crx1YR/SfB41hfDYmI9jxzk8Ryxa8Ve/h/yCnmWkATw=;
        b=bP9oDx4uKOIkZ4JQyMDPf3CtQAAZMCXOwZjxwGO9SWXC8N21MdXYS7COF+MSWGwNAo
         0O03ATcl6DQht9lQDrTFh75woO2ARcboROFOuBUreQSlFmN/hLifBrQ3TatrGuZfxtpn
         iToTxpYBlH90M6JUZKyJP83+EJ3XUE5K2sU7g8T1ghRP8yjCs9Y1rheF9AB+t8jIfOxn
         Ug4zRpY2cOFFeQoqgDtVApySjo6a2K78F00e+kvNdPDDzsueL1uMzGHTuNlq+YX4KQeu
         6U6TBtyknXOXyLzLZmSuxmFAkEksYkPKKW0fOQcaebk6AtQ04r3cL7itz8owJm1C62gN
         V8zA==
X-Forwarded-Encrypted: i=1; AKwUvBwJGtq5vsAuqs9Qu+5jM7c2QnYuaF7NK3aBW2Kun8mlDtpLB1c9hiq+qLXlx03tZ1QCSFagCFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2LDADeAZ03aLve2d/MbOM2yKK+r0wZxGy8A0Bri1crDYsxEAW
	9iteZPRfOiTUg1V/zyoH4mWfE0FrSruIj0qORfsJBolwG1vPQwt8qEzBMhPxRA/GwAY=
X-Gm-Gg: AYBFou2nRXkopRYx74dHwpixw/q9d6vP0N/+oM0w+ZwJBAa+Mp/01I+Z2nEdtAbqBx3
	/NjO0RS3RuzJhSNfJQ/xCAkgpTMxi5Z9ROk3l/oC7iJlHIAi0t25ALMI0Z4Aqtq3lH0y5MBOZQR
	Ffo3U0cQnReYqxqbe5qhVxDpr/sEYwK9N4i+F1OkAntVvcCSWAOtzy04tMSDxmOtXU6N6oA1wYD
	R71dm/qys+y+PdIjmb9FPGR1lIEjsM7PnM00VKYJlSMtXE25px0WPC08XEBfqd9ohg+/rjDOWel
	Aek/vZjkCaPOfics+HuwSLXndxXTeA9lTjlngAFndS7OG7kuPQyXaFkdOhg/HbxH1dR0BAj9iGE
	pWzvzrB0iZbd1RboDVz4gmX+g62FMrZ3rXBQsJa3EE72ZfnF6DF3ioEpeBgIEWzAFbHgHMeAy+B
	nvCg/rdYmlf08jn4ytEVDEeFKNVGfrrpj2WXY7CQqVWLNZcznF0ugjURGufbUE9MjLy4/neN109
	bffYSKYxmDbOzCMlZcM79hQxpsVq/GdPjwn
X-Received: by 2002:a05:6a00:983:b0:89e:8423:6863 with SMTP id d2e1a72fcca58-89e84236d2emr2125283b3a.37.1792078339508;
        Thu, 15 Oct 2026 08:32:19 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89e45dcb382sm1273564b3a.15.2026.10.15.08.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:32:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [REGRESSION] 6.12.111: "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU" breaks TCP through relays when the
 peer's network drops ICMP
From: Echoo Wall <echoowall@gmail.com>
In-Reply-To: <9776e821-f95e-4ee4-8595-4bbf4b48ad36@leemhuis.info>
Date: Thu, 15 Oct 2026 23:31:51 +0800
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org,
 regressions@lists.linux.dev,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <171BADBE-5209-4AA9-A144-50ABBA2D366E@gmail.com>
References: <4F0FAEB6-A13B-47F3-BFF1-C706686C6F64@gmail.com>
 <9776e821-f95e-4ee4-8595-4bbf4b48ad36@leemhuis.info>
To: Thorsten Leemhuis <regressions@leemhuis.info>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On 10/15/26, Thorsten Leemhuis wrote:
> Thx for the report. That is a mainline commit, but this might be a
> stable specific thing due to a broken backport. These cases in the end
> might be handled by different people, so somebody needs to check which
> if the two it is. Could you thus check if 7.3-rc7 or later is still
> affected? If it is, please try to check if reverting the commit fixes
> things; if it is not, please check a revert with the stable series you =
use.

7.3-rc7 is affected, and reverting =
2640e64195948a601430d230c9864f5426574cde
on top of 7.3-rc7 fixes it. So this is not a broken backport; mainline
behaves the same as 6.12.111.

To make this reproducible without our production setup, I wrote a small
reproducer that runs on a single host with network namespaces (script
below):

  cli --(1500)-- r1 --(1456)-- r2 --(1500)-- srv

srv first learns PMTU 1456 towards cli (r2 sends it ICMP frag-needed),
then cli connects to srv and uploads 1 MB. r1 drops the ICMP
frag-needed that would go back to cli, like a firewall in front of the
client. All kernels run in the same KVM guest (Debian 13 userspace).

Results (3 runs each, identical every time):

  kernel                        srv PMTU   SYN-ACK MSS   1 MB upload
  6.12.107 (Debian)             1456       1416          OK (0.03s)
  6.12.111 (Debian)             1456       1460          stalls, 10s =
timeout
  7.3-rc7                       1456       1460          stalls, 10s =
timeout
  7.3-rc7 + revert of 2640e641  1456       1416          OK (0.03s)

The two 7.3-rc7 kernels were built from the same tree and the same
.config (Debian's 6.12 config + localmodconfig); the only difference is
the revert, which applies cleanly (4 files changed, 3 insertions(+),
65 deletions(-)).

Controls:

- Forcing srv to advertise 1460 (ip route ... advmss 1460) stalls on
  every kernel, including 6.12.107 and the revert, and r1 counts 8
  dropped frag-needed per run. So the black hole is real and is
  triggered exactly by the advertised MSS.
- Clamping MSS to 1416 on r1 (nft: tcp option maxseg size set 1416)
  makes 6.12.111 work again (3/3). That is the workaround we have
  deployed on our relays.

This also confirms the two points I had marked as not yet verified in
my original report.

Reproducer (run as root; needs iproute2, nft, tcpdump, python3, bc;
optional argument "force1460" or "clamp" for the controls above):

---8<---
#!/bin/bash
# cli --(1500)-- r1 --(1456)-- r2 --(1500)-- srv
set -u
MODE=3D"${1:-}"
NS=3D"cli r1 r2 srv"
cleanup(){ for n in $NS; do ip netns del $n 2>/dev/null; done; }
cleanup
for n in $NS; do ip netns add $n; ip -n $n link set lo up; done
ip link add c0 netns cli type veth peer name r1a netns r1
ip link add r1b netns r1 type veth peer name r2a netns r2
ip link add r2b netns r2 type veth peer name s0 netns srv
ip -n cli addr add 10.0.1.2/24 dev c0;  ip -n r1 addr add 10.0.1.1/24 =
dev r1a
ip -n r1 addr add 10.0.2.1/24 dev r1b;  ip -n r2 addr add 10.0.2.2/24 =
dev r2a
ip -n r2 addr add 10.0.3.1/24 dev r2b;  ip -n srv addr add 10.0.3.2/24 =
dev s0
ip -n r1 link set r1b mtu 1456; ip -n r2 link set r2a mtu 1456
for d in "cli c0" "r1 r1a" "r1 r1b" "r2 r2a" "r2 r2b" "srv s0"; do set =
-- $d; ip -n $1 link set $2 up; done
ip -n cli route add default via 10.0.1.1
ip -n srv route add default via 10.0.3.1
ip -n r1 route add 10.0.3.0/24 via 10.0.2.2
ip -n r2 route add 10.0.1.0/24 via 10.0.2.1
for n in r1 r2; do ip netns exec $n sysctl -qw net.ipv4.ip_forward=3D1; =
done
for n in cli srv; do ip netns exec $n sysctl -qw =
net.ipv4.tcp_mtu_probing=3D0; done
ip netns exec r1 nft -f - <<NFT
table inet fw {
  chain f1 {
    type filter hook forward priority 0;
    ip daddr 10.0.1.0/24 icmp type destination-unreachable icmp code =
frag-needed counter drop
  }
  chain o1 {
    type filter hook output priority 0;
    ip daddr 10.0.1.0/24 icmp type destination-unreachable icmp code =
frag-needed counter drop
  }
}
NFT
[ "$MODE" =3D "force1460" ] && ip -n srv route add 10.0.1.0/24 via =
10.0.3.1 advmss 1460
[ "$MODE" =3D "clamp" ] && ip netns exec r1 nft add rule inet fw f1 tcp =
flags syn tcp option maxseg size gt 1416 tcp option maxseg size set 1416
ip netns exec srv ping -c 2 -W 1 -M do -s 1472 10.0.1.2 >/dev/null 2>&1
ip netns exec srv ping -c 1 -W 1 -M do -s 1472 10.0.1.2 >/dev/null 2>&1
PMTU=3D$(ip netns exec srv ip route get 10.0.1.2 | grep -o 'mtu [0-9]*' =
|| echo "none")
ip netns exec srv python3 -c '
import socket
s=3Dsocket.socket(); =
s.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1); =
s.bind(("0.0.0.0",9000)); s.listen()
c,_=3Ds.accept(); n=3D0
while True:
    b=3Dc.recv(65536)
    if not b: break
    n+=3Dlen(b)
c.sendall(str(n).encode()); c.close()' &
SP=3D$!
rm -f /tmp/synack.pcap
ip netns exec srv tcpdump --immediate-mode -nni any -U -w =
/tmp/synack.pcap 'tcp src port 9000 and tcp[13] & 18 =3D=3D 18' =
2>/dev/null &
TP=3D$!
sleep 3
START=3D$(date +%s.%N)
RES=3D$(ip netns exec cli timeout 10 python3 -c '
import socket
s=3Dsocket.create_connection(("10.0.3.2",9000),timeout=3D10)
s.sendall(b"x"*1048576); s.shutdown(socket.SHUT_WR); =
print(s.recv(100).decode())' 2>&1 | tail -1)
END=3D$(date +%s.%N)
sleep 2; kill $TP $SP 2>/dev/null; wait 2>/dev/null
MSS=3D$(tcpdump -nr /tmp/synack.pcap -v 2>/dev/null | grep -o 'mss =
[0-9]*' | head -1)
DROPS=3D$(ip netns exec r1 nft list ruleset | grep -o "packets [0-9]*" | =
awk "{s+=3D\$2} END{print s}")
echo "kernel=3D$(uname -r)${MODE:+ [$MODE]} | srv PMTU: ${PMTU} | =
SYN-ACK: ${MSS:-none} | 1MB upload: $( [ "$RES" =3D "1048576" ] && =
printf 'OK in %.2fs' $(echo "$END - $START" | bc) || echo "FAILED =
(${RES:-timeout})") | frag-needed dropped by r1: ${DROPS:-0}"
cleanup
---8<---

Note that in "clamp" mode the capture on srv still shows 1460, since the
rewrite happens on r1; the client sees 1416.

Thanks.
Esko Mobius


> 2026=E5=B9=B410=E6=9C=8815=E6=97=A5 17:04=EF=BC=8CThorsten Leemhuis =
<regressions@leemhuis.info> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 10/9/26 18:27, Echoo Wall wrote:
>>=20
>> After a routine stable update from 6.12.107 to 6.12.111 (Debian =
trixie-security,
>> 6.12.111-1), TCP connections to our servers started timing out for a =
subset of
>> clients. Booting back to 6.12.107 / 6.12.101 fixed it immediately. I =
believe the
>> cause is:
>>=20
>>  2640e64195948a601430d230c9864f5426574cde
>>  net: advertise TCP MSS from the configured MTU, not the learned PMTU
>>  (in stable 6.12.111 and 6.18.51)
>>=20
>> #regzbot introduced: 2640e64195948a601430d230c9864f5426574cde
>=20
> Thx for the report. That is a mainline commit, but this might be a
> stable specific thing due to a broken backport. These cases in the end
> might be handled by different people, so somebody needs to check which
> if the two it is. Could you thus check if 7.3-rc7 or later is still
> affected? If it is, please try to check if reverting the commit fixes
> things; if it is not, please check a revert with the stable series you =
use.
>=20
> Ciao, Thorsten
>> Topology
>> --------
>>=20
>>  client ---(internet)---> relay (Linux, nftables DNAT + masquerade) =
---> server
>>                                                               ^
>>                                                 path MTU 1456 on this =
hop
>>=20
>> - Servers have a 1500-byte interface MTU, but the path between the =
relay and the
>>  server has a PMTU of 1456 (encapsulation upstream). The server =
learns this
>>  correctly: `ip route get <relay>` shows `cache mtu 1456`.
>> - Clients reach the server only through the relay (port-based DNAT, =
SNAT to the
>>  relay address).
>> - Some client networks (typical corporate firewalls) drop ICMP
>>  "fragmentation needed".
>>=20
>> Behaviour
>> ---------
>>=20
>> Before (<=3D 6.12.110): the server's SYN-ACK advertised MSS 1416, =
derived from the
>> learned PMTU. Clients never sent segments that were too large. =
Everything worked,
>> including from networks that filter ICMP.
>>=20
>> After (6.12.111): the SYN-ACK advertises MSS 1460 from the configured =
MTU. The
>> client sends 1500-byte packets. They are dropped at the 1456 hop, and =
the ICMP
>> error never reaches the client because its network filters it. The =
handshake
>> completes, then the connection stalls: a classic PMTU black hole.
>>=20
>> Direct connections to the same servers, without the relay hop, keep =
working, and
>> so do servers still on <=3D 6.12.110 behind the same relays. That =
made the problem
>> very hard to attribute: it only appears from certain client networks, =
only on
>> relayed paths, and only after a kernel update that nothing points to.
>>=20
>> What I verified
>> ---------------
>>=20
>> - Reproducible per host by switching only the kernel. Rebooting =
without changing
>>  the kernel does not help. Same sysctls on both kernels (309 TCP =
parameters
>>  compared), same userspace.
>> - On 6.12.107 the server has `cache mtu 1456` towards the relay, so =
the
>>  SYN-ACK MSS is derived from it (1416). With this commit the =
advertised
>>  MSS comes from the 1500-byte device MTU (1460) instead. That matches =
the
>>  symptom exactly, but I have not yet captured a 6.12.111 SYN-ACK on =
the
>>  affected path.
>> - As a workaround we now clamp MSS on the relay
>>  (`tcp flags syn tcp option maxseg size > 1416 tcp option maxseg size =
set 1416`
>>  in the forward chain). I have not yet re-tested 6.12.111 behind it.
>>=20
>> Why I think this matters
>> ------------------------
>>=20
>> The commit message argues that on symmetric paths nothing is lost =
because "the
>> peer usually already knows the real path MTU". That assumption does =
not hold when:
>>=20
>>  1. the peer sits behind a firewall that drops ICMP =
fragmentation-needed, which
>>     is common in enterprise networks; and/or
>>  2. the narrow hop is only on the server side (relay, tunnel or =
overlay egress),
>>     so the peer has no way to learn it other than via ICMP.
>>=20
>> In both cases the receiver-side PMTU knowledge was the only thing =
that kept the
>> connection working. The old behaviour was effectively a built-in =
safeguard for
>> these black holes, and it has been in place for a very long time.
>>=20
>> This is now shipping as a security update in LTS/stable kernels and
>> distributions. It silently breaks previously working deployments, and =
only for
>> some users, so most operators will not connect the symptom to the =
kernel. The
>> 6.6 / 6.1 / 5.15 backports appear to be still pending, so there may =
still be
>> time to reconsider before it spreads further.
>>=20
>> Possible ways forward (just suggestions):
>>=20
>>  - revert from stable and keep it in mainline until there is a safer =
variant;
>>  - make it opt-in (sysctl or per-route flag) for the asymmetric / DSR =
case it
>>    targets;
>>  - or only ignore the learned PMTU when there is evidence of =
asymmetry, instead
>>    of unconditionally.
>>=20
>> I am happy to test patches on the affected setup.
>>=20
>> Thanks.
>> Esko Mobius
>=20

