Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795410457;
	b=SMZuTFNqxaClrjAicBuLlk1g5KwuL36z/zi35g96quxLi+DTkFCNUZVY3q2/STob8tIN
	 PFNjKg1Mr1WQd7nMRYJ+nrdlFbkPp6fcsY0zCSQv49eUQnhjijl7TaYhNP71d76mlaU5U
	 /fJduSCNZuicdxoUn7WidhuCU55fCnIE/31l9iyqbfiVt0m7vV/GIr85qeGKlC0uVgpaR
	 p9dt58lwKgciD0hebKMBHiSPoDuRMvEHSIUpM8igmdjtYlCK9k2GyZcOELhCKMpjSvMcE
	 Km2UHazhIPjinc6rsmyJ0aDgqtp29yEdjd0UOT49vT17z6XsBxkBvg1mSdcOS2zSWpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410457;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=/81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=;
	b=mRAF0w59PEYxRx349/q2umbAbycujoUftt1zJ6BRXxUwrCQRqOOqFdK6vVa+rDbqfn3o
	 sYxMvdRFelcoQYHfE4CBKE/71rZU6UzmNAfzml+iM1fQYVKgfevYAISctF2G90izHjl1/
	 /whRWs22X7fsi7bau76ul0rqpawqwxjewplSh6QRvHubrJjyS65OeNpk7vld0KndKPRk3
	 yVv8CdH0y9aPQsA5+6JZ8rPG9699pDD2EH6agL1uNiLYzIWzf1QyPJchZt0z0vOabh4SZ
	 /BX/uppJ4BV9dBvek4hduMQdVUYnPe6FW1yEHdNaxASoMT1FPc1BpZSzAdCwMU8oi2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=SKecWwbz;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=tjp0B9dp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E4606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA3E4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=SKecWwbz;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=tjp0B9dp
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN03wK92372238
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=/
	81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=; b=SKecWwbzU2u9GAUzJ
	mrZL/kgVq6L2kvuwaF/YIfl+qgqmmDSt2sOblwR7tFCY6lTY3GflTsPF4J82l9S8
	/p2yQpxxeQeNG5+8UBqhhJtFdZON/7pPmq1hREBksdQPPU1XE16EcfELFmQVK4/k
	jUfHdceuuZXG/jzPGDDu3UeSJC/fMMqly7KA+mq4UdFy15bpBYRSTNt+4bgoGFDQ
	zOhDZCJBP7L9wwHWqG/Bqb8J046E5o7q8j0TlQB5JThmdcPeXBoFw6EUZXUtzBv7
	mR7gwOyl30KUO1K28KRK7E27EaHm4u0PngI/D1Rxc3zkaqVmP7m32oah8JmgFzbs
	RZxvg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4j4amb1xgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:07:30 -0500 (EST)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386ad819860so1880941eec.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:07:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795410449; cv=none;
        d=google.com; s=arc-20260327;
        b=czdPiHP8h2zBDN1neDH/X/J2ccmi1MnhTxSOTvP7S76eOF55/TB0k6uOyN0xoZnz1a
         ZbsGogih4SLuPHviPadVfTiepNHI/AqdMVbmsNM30CWCVS4aJBRaigKG9xEmrXBZp+iK
         sZgI25/9hkip2BNQLK750JwaQGmwOw1sLj4ebLJyh8laDqQ5bkK0A5u7Lew2oMinQv5e
         dL9Op4fKi0AYK3Q8+chJqWEb8BfvAqTcJEqz7e+RdR6dMlx1mCZEszBQVFs4+vbrm9e5
         Vehee4WksHy4EerPbSgz6tcURdrJnsYlHTYN4IG6QhITWNeNWNXIVZ6HUdlNPh5UxZTY
         BJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=;
        fh=mfIyn8j3nsWYXzj9WR3umPT8+Fa85pWT1XFp+V7utUk=;
        b=m9RsibBomMF7gRrRKX2Cs5a2S7S/ytk+5SphB/DTagNElK3SD0yosmXvY1cFv1M2+/
         qkC1N3g8Zuyd9UJkOPngEy4w2lKOWTJ0sJdwKly7eOk5Zy64eFlribaHg8yvNgpLWmYx
         TP8a7Q2gnwanMF0i00pDzH3EkQItvwwKNmnDUQMnJwOFqpktifcR45lnFjJPlZb6X1yq
         gdkSXR1dO+3D312xgACjzr4FQAYpOiXb8YE8oRxtmhBwkhtHNsw6CQhdMU84XI+xaiT7
         TsAORzKRI1Up3Pjasg4cAv59ZbEewFKe5P45C+9Wbg0GqPuh5ApqUjy39iQGFTUI+YCT
         d8QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1795410449; x=1796015249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=;
        b=tjp0B9dpUTtHvZKITdtIzMLBR9uWyBxF5CO7WT456ajRggZ+ouCiU+WUTOp4MPjit7
         Tfwv8gC8k9mf5IaIs2Nfyt/xc9S0zFOpCdkU97pMmpoe+PzOtgqsQ/lRn+F0u4Z5ij2v
         FDFaNXJR4/vigltQVf82L+OCqIsnh26t4TVrnxzpqlkNzrMqMSXbm76tRvW7sQVmi2YB
         D2oLamng2ZPNMsN5AkcsJAfpNrZE32FQ4ZKaPM8baj3rU2AHghyLbFzoD1a0C7MXCdpO
         Ql0tCtDMSJxXAtcSvnFZogHxSxj5FBbE5nUCDUy/0ORxXAnCFQuPYstSX2YY4O3dXoD/
         c1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795410449; x=1796015249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=;
        b=Fi8hjd0bK7phq4RzWpGOGQcCwLJZIhuJBT4iEukpD4VUNBB/bexoziWZZuUf1/Kf7w
         M9GljwDl4SeGdh3zCUFVx99UnBI04a0P8reH9VPIE0Ep49qF2MWPj5s+oJUHz+6dK4fR
         k79NEwuZ6wzZjl1uytpoJ40SpvLuKvg1LhEU6HnUx/sd2ky930DCdZTUIuyIyeH2KjAk
         nLY6Ill1lJ9gvkPzKFXYf9BQTGd/aCn1nb1D6BnFEZBShh6amqWb+l9WEOOBpZQOYhTO
         QBz67rdLI6sq/ZGDCIXs3IuZhUTMXxe+sSsW09HXwMeuCd9UogqRKnvEDEDsYJ9I53J3
         O9Gw==
X-Forwarded-Encrypted: i=1; AL+hErEilDDvqTtO890qboeInnRey0WtQMwmKMTn0Xjc5GKurEEgkusUr5yNb+va9fWo+PMT7sMNR8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Dvvf2VLBdLIDrhNTC5pBiAKhvlZqpvfBtU6psKudwXxNH5chC
	0ckJHK6SwTRwX0y5qkDhpxRF2Jj/W8sTHnbGqL7g+Cz9RRv3kdPjRHC9vvc3RO034h1iN0P37fY
	ljqTLvJaq46g56b67uPw9GqkgEGiJefTb3RzjZGd5hyRPXFMyiNNjam/UfI7OHxM+4RJS7sZn4s
	F3cWzf+jIBTs+/6iV4kLmUYPkZsl5YOQ==
X-Gm-Gg: AZFdTZcXY6cZMtl9j69TGXKqZWwYFlMrbIXivj3YliyD6cu7GSRxsTVogYSMTzCCnOH
	xthiufbJQ6rfqzTSsNTh3CK8DdL3cNZAYh+jSrQ0QEqTIbN3tvYolAwTf6bEBTSG5TdPGnI98uQ
	HV+U0qyrACmwSOAUTaC/+XEpqjJDVLOB5IuB0Qbro08zzEyCOOMPnlfLjXig==
X-Received: by 2002:a05:7301:df48:b0:386:a5d0:15d9 with SMTP id 5a478bee46e88-386a5d018c8mr4769335eec.37.1795410449604;
        Sun, 22 Nov 2026 21:07:29 -0800 (PST)
X-Received: by 2002:a05:7301:df48:b0:386:a5d0:15d9 with SMTP id
 5a478bee46e88-386a5d018c8mr4769315eec.37.1795410449104; Sun, 22 Nov 2026
 21:07:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113030257.1061200-2-kj2864@nyu.edu> <20261122181622.1294305-1-amarkuze@redhat.com>
In-Reply-To: <20261122181622.1294305-1-amarkuze@redhat.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Mon, 23 Nov 2026 00:07:18 -0500
X-Gm-Features: Aa3M54rDQBOKRDXbJgbB5JJzrGqttkv3os_tIAGF8WXn09halqO4jreeG9nkw0Q
Message-ID: <CAPqbLS1vgOhyXT8zLiDmf_1W3zVq3cgAcvu0AbmKCSUCstpqaA@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: Use unsigned types for snapshot split counts
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
        Xiubo Li <xiubli@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+408fcc361565713f@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX0yah7rQ3+kwX
 1uUBuhGrlSCMfkLwnFxYxodSEtGl3GNgvgi4KikhA+s3U1zqtk4Y6WHcjkkwO/vdT9lfADDBnql
 FKt5MrjnTKRG1+0m+k7kn2hZW2zfp8w6xV3UKTMqy7C3venNxoxfiDejluZN3GhPSUMDqzWOeHK
 TO62lUuXqZxvt2NvMEA5X16pjwAtDTLUaN+sjRz63C6xrbHYAfOtNJW5syoOE6kax7BKRsxzJmM
 ALniv6g/CpDlPtmmILTGruJCpisGYhiz6+wq/6qe+P2qz9wZWzjGHcXQ46H1kS6I5ZmP1nuByUn
 p5zQJ468qRKdV2QyHzyv8ZwJe/+piIrTUm91EwH0UgtDKNE6l9zJ94PDeS9CBUDj/2OHwDJAz8k
 fndAD+3stf473tnQ8nZWKM/zYMl+iEfWvbaev74lWZGsYyZYxfh0w9I3wUYzpNZZFSfJ+SXnGyw
 ybFgBC8M+LHYVMqCKHA==
X-Proofpoint-ORIG-GUID: AmXxSC4U4cmZASE9SDXnBiOG8nTBvY5T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfXx5tFaJL1aC5x
 yLCRiAAQHb7eFYrYF6NotToPdz6Vz7PsgUiTTqP2heI6HNfKBDGyBeX1/7j7y2cS8NdRKQf2CqO
 7zI253CVk3xn/qYDYUAEucHBxD/89yg=
X-Authority-Analysis: v=2.4 cv=L9aI0OT8 c=1 sm=1 tr=0 ts=6b03ca12 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=CxnIfPQeirmdGRAfp5MW:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=ItuYklrUK8AZe7o1UmoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: AmXxSC4U4cmZASE9SDXnBiOG8nTBvY5T
X-Orig-IP: 74.125.82.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230019

Hi Alex,

I've made the changes you've requested, please let me know if any
issues occur in my patch or anything further to fix.

v3 has been proposed:
https://lore.kernel.org/all/20261123050440.223436-2-kj2864@nyu.edu/



On Sun, Nov 22, 2026 at 1:16=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Hi Kaho,
>
> The new array-length checks return through ceph_handle_snap()'s bad
> label, which drops the message without fencing I/O. If the MDS sends a
> malformed snapshot update, the client can miss it and continue writing
> with an out-of-date snapshot context, risking snapshot contents.
>
> Please fence I/O on these failures and use the same blocklisting and
> session-close handling as for a corrupt snap trace.
>
> Thanks,
> Alex
>
